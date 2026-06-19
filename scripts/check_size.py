import sys
import json
import os

try:
    data = json.load(sys.stdin)
    fp = data.get('tool_input', {}).get('file_path', '')

    if not fp or not fp.endswith('.md'):
        sys.exit(0)

    norm = fp.replace('\\', '/')
    watched = ['VMD_MASTER.md', 'CLAUDE.md', 'memory/decisions.md', 'memory/progress.md']
    if not any(w in norm for w in watched):
        sys.exit(0)

    try:
        with open(fp, 'r', encoding='utf-8', errors='ignore') as f:
            lines = sum(1 for _ in f)
    except Exception:
        sys.exit(0)

    limits = {
        'VMD_MASTER.md': 150,
        'CLAUDE.md': 120,
        'decisions.md': 80,
        'progress.md': 100,
    }
    fname = os.path.basename(fp)
    limit = limits.get(fname, 100)

    if lines > limit:
        over = lines - limit
        print(f'⚠️  [SIZE GUARD] {fname} {lines}줄 → 한도 {limit}줄 {over}줄 초과!')
        if fname == 'CLAUDE.md':
            print('   → .claude/ 파일로 섹션 분리 후 @ 참조 권장')
        elif fname == 'VMD_MASTER.md':
            print('   → 오래된 시즌 기록을 seasons/ 폴더로 이동 권장')
        else:
            print('   → 압축·분할 처리 필요')

except Exception:
    pass
