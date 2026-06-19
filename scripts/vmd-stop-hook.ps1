# VMD Ops — Stop Hook
# Claude 세션 종료 시 자동 실행:
# 1. 오늘 작업 로그 업데이트 (memory/daily/YYYY-MM-DD.md)
# 2. Git 변경사항 확인 → 커밋/푸쉬 여부 알림

$projectRoot = "D:\0.vmd ops"
$date = Get-Date -Format "yyyy-MM-dd"
$time = Get-Date -Format "HH:mm"
$dailyDir = "$projectRoot\memory\daily"
$dailyLog = "$dailyDir\$date.md"

Set-Location $projectRoot

# ── 1. Git 변경사항 확인 ──────────────────────────────────────
$gitStatus = git status --short 2>&1
$hasChanges = $gitStatus -and ($gitStatus -notmatch "^$")

# ── 2. 오늘 작업 로그 업데이트 ──────────────────────────────────
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

# ── 3. 변경사항 없으면 종료 ──────────────────────────────────────
if (-not $hasChanges) { exit 0 }

# ── 4. 커밋/푸쉬 확인 알림 팝업 ──────────────────────────────────
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

# ── 5. 커밋 & 푸쉬 ──────────────────────────────────────────────
if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
    git add .

    # 변경 파일 기반 자동 커밋 메시지 생성
    $changedFiles = git diff --cached --name-only 2>&1
    $summary = ($changedFiles | Select-Object -First 3) -join ", "
    if ($changedFiles.Count -gt 3) { $summary += " 외 $($changedFiles.Count - 3)개" }
    $commitMsg = "update($date $time): $summary"

    git commit -m $commitMsg

    $pushResult = git push origin master 2>&1
    $pushSuccess = $LASTEXITCODE -eq 0

    # 완료 알림
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
