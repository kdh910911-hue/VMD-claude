# VMD Ops — Stop Hook
# Claude 세션 종료 시 자동 실행:
# 1. memory 백업 (progress.md, decisions.md → memory/backup/TIMESTAMP/)
# 2. progress.md 완료([x]) 항목 자동 정리
# 3. VMD_MASTER.md ↔ decisions.md 날짜 정합성 감지
# 4. 오늘 작업 로그 업데이트 (memory/daily/YYYY-MM-DD.md)
# 5. Git 변경사항 확인 → 커밋/푸쉬 여부 알림

$projectRoot = "D:\0.vmd ops"
$date = Get-Date -Format "yyyy-MM-dd"
$time = Get-Date -Format "HH:mm"
$dailyDir = "$projectRoot\memory\daily"
$dailyLog = "$dailyDir\$date.md"

Set-Location $projectRoot

# ── 1. memory 백업 ───────────────────────────────────────────
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$backupDir = "$projectRoot\memory\backup\$timestamp"
New-Item -ItemType Directory -Force $backupDir | Out-Null
@("progress.md", "decisions.md") | ForEach-Object {
    $src = "$projectRoot\memory\$_"
    if (Test-Path $src) { Copy-Item $src $backupDir }
}
# 최근 3개 백업만 유지
$allBackups = Get-ChildItem "$projectRoot\memory\backup" -Directory -ErrorAction SilentlyContinue | Sort-Object Name -Descending
if ($allBackups.Count -gt 3) {
    $allBackups | Select-Object -Skip 3 | Remove-Item -Recurse -Force
}

# ── 2. progress.md 완료 항목([x]) 자동 정리 ─────────────────
$progressPath = "$projectRoot\memory\progress.md"
if (Test-Path $progressPath) {
    $content = Get-Content $progressPath -Encoding UTF8
    $cleaned = $content | Where-Object { $_ -notmatch '^\- \[x\]' }
    $cleaned | Set-Content $progressPath -Encoding UTF8
}

# ── 3. VMD_MASTER ↔ decisions.md 날짜 정합성 감지 ───────────
$masterPath = "$projectRoot\VMD_MASTER.md"
$decisionsPath = "$projectRoot\memory\decisions.md"
if ((Test-Path $masterPath) -and (Test-Path $decisionsPath) -and (Test-Path $progressPath)) {
    $masterContent = Get-Content $masterPath -Raw -ErrorAction SilentlyContinue
    $decisionsContent = Get-Content $decisionsPath -Raw -ErrorAction SilentlyContinue

    $masterDateMatch = [regex]::Match($masterContent, '\d{4}-\d{2}-\d{2}')
    $decDateMatches = [regex]::Matches($decisionsContent, '\d{4}-\d{2}-\d{2}')

    if ($masterDateMatch.Success -and $decDateMatches.Count -gt 0) {
        $masterDate = $masterDateMatch.Value
        $latestDecDate = ($decDateMatches | ForEach-Object { $_.Value } | Sort-Object -Descending)[0]

        if ($latestDecDate -gt $masterDate) {
            $progressContent = Get-Content $progressPath -Raw
            if ($progressContent -notmatch '자동감지.*VMD_MASTER') {
                $warning = "`n> ⚠️ [자동감지] VMD_MASTER.md($masterDate) 이후 새 결정 있음($latestDecDate) — 세션 시작 시 정합성 체크 필수"
                Add-Content $progressPath $warning -Encoding UTF8
            }
        }
    }
}

# ── 4. Git 변경사항 확인 ──────────────────────────────────────
$gitStatus = git status --short 2>&1
$hasChanges = $gitStatus -and ($gitStatus -notmatch "^$")

# ── 5. 오늘 작업 로그 업데이트 ──────────────────────────────────
if (-not (Test-Path $dailyDir)) {
    New-Item -ItemType Directory -Force $dailyDir | Out-Null
}

$entry = "`n## $time 세션 완료`n"

if ($hasChanges) {
    $entry += "### 변경 파일`n"
    foreach ($line in $gitStatus) {
        if ($line.Trim()) { $entry += "- $line`n" }
    }
} else {
    $entry += "변경사항 없음`n"
}

if (-not (Test-Path $dailyLog)) {
    "# $date 작업 로그`n" | Set-Content $dailyLog -Encoding UTF8
}
$entry | Add-Content $dailyLog -Encoding UTF8

# ── 6. 변경사항 없으면 종료 ──────────────────────────────────────
if (-not $hasChanges) { exit 0 }

# ── 7. 커밋/푸쉬 확인 알림 팝업 ──────────────────────────────────
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$changedList = ($gitStatus | Where-Object { $_.Trim() }) -join "`n"
$message = "VMD Ops 작업이 완료됐어요.`n`n변경된 파일:`n$changedList`n`nGit 커밋 & 푸쉬할까요?"

$result = [System.Windows.Forms.MessageBox]::Show(
    $message,
    "VMD Ops — 작업 완료 알림",
    [System.Windows.Forms.MessageBoxButtons]::YesNo,
    [System.Windows.Forms.MessageBoxIcon]::Question,
    [System.Windows.Forms.MessageBoxDefaultButton]::Button1
)

# ── 8. 커밋 & 푸쉬 ──────────────────────────────────────────────
if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
    git add .

    $changedFiles = git diff --cached --name-only 2>&1
    $summary = ($changedFiles | Select-Object -First 3) -join ", "
    if ($changedFiles.Count -gt 3) { $summary += " 외 $($changedFiles.Count - 3)개" }
    $commitMsg = "update($date $time): $summary"

    git commit -m $commitMsg

    $pushResult = git push origin master 2>&1
    $pushSuccess = $LASTEXITCODE -eq 0

    $resultMsg = if ($pushSuccess) {
        "✅ 커밋 & 푸쉬 완료!`n`n$commitMsg`n`n$date 작업 로그도 업데이트됐어요."
    } else {
        "⚠️ 커밋은 됐지만 푸쉬 실패`n$pushResult"
    }

    [System.Windows.Forms.MessageBox]::Show(
        $resultMsg,
        "VMD Ops",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Information
    ) | Out-Null
}
