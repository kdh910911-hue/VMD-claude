import sys
import json
import os

if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8')

BLOCKED_EXTS = {
    '.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp', '.svg', '.ico', '.tiff', '.tif',
    '.mp4', '.mov', '.avi', '.mkv', '.wmv', '.flv',
    '.ai', '.psd', '.eps', '.indd', '.xd',
    '.pdf', '.hwpx', '.hwp', '.docx', '.doc', '.xlsx', '.xls', '.pptx', '.ppt',
    '.stp', '.step', '.stl', '.obj', '.fbx',
    '.mp3', '.wav', '.aac', '.flac', '.ogg',
    '.zip', '.rar', '.7z', '.tar', '.gz',
}

try:
    data = json.load(sys.stdin)
    file_path = data.get('tool_input', {}).get('file_path', '')
    ext = os.path.splitext(file_path)[1].lower()

    if ext not in BLOCKED_EXTS:
        sys.exit(0)

    filename = os.path.basename(file_path)

    # allowlist 확인 — 명시적으로 허용한 파일인지 체크
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_dir = os.path.dirname(script_dir)
    allowlist_path = os.path.join(project_dir, 'memory', '.binary_read_allowlist')

    if os.path.exists(allowlist_path):
        with open(allowlist_path, 'r', encoding='utf-8') as f:
            entries = [line.strip() for line in f if line.strip()]

        for entry in entries:
            if entry and (
                os.path.basename(file_path) == entry
                or file_path.endswith(entry)
                or entry in file_path
            ):
                # 1회 소모 — allowlist에서 제거
                remaining = [e for e in entries if e != entry]
                with open(allowlist_path, 'w', encoding='utf-8') as f:
                    f.write('\n'.join(remaining) + ('\n' if remaining else ''))
                sys.exit(0)

    print(f'[BINARY READ GUARD] 차단: {filename}')
    print()
    print('바이너리/미디어 파일은 확인 없이 읽을 수 없습니다.')
    print()
    print('▶ 명시적으로 요청한 경우:')
    print('  memory/.binary_read_allowlist 에 파일명을 추가 후 다시 Read (1회 자동 소모)')
    print()
    print('▶ 자체 판단으로 필요하다고 생각된 경우:')
    print(f'  "{filename}을 확인해야 할 것 같은데, 봐도 될까요?" 라고 먼저 확인')
    sys.exit(2)

except Exception:
    pass

sys.exit(0)
