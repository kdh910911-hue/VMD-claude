# Progress — 현재 진행 상황

> 세션 시작 시 첫 번째로 읽는 파일.
> 매 세션 종료 전 반드시 업데이트.

---

## 현재 시즌
```
활성 시즌: (입력 필요 — 예: 2025 SS)
시즌 단계: (입력 필요 — 예: 3주 전 / 기획 중 / 실행 완료)
```

---

## 완료된 작업
```
2026-06-19 — VMD ops Claude Code 시스템 초기 구축
             CLAUDE.md, VMD_MASTER.md, 에이전트 5인, 세션 프로토콜 적용

2026-06-19 — config-ops 레포 검토 + VMD Ops 자동화 고도화
             A. Stop 훅 업그레이드 — memory/backup/ 자동 스냅샷, 최근 3개 유지
             B. check_size.py — Edit/Write 후 MD 파일 크기 자동 감지 (PostToolUse 훅)
             C. block_binary_reads.py — 이미지/PDF 실수 Read 차단 (PreToolUse 훅)
             D. VMD_MASTER 정합성 감지 — decisions 날짜 > MASTER 날짜 시 자동 경고
             AI VMD Creator 에이전트 추가 (에이전트 6인 체계)
```

---

## 다음 우선순위
```
1. VMD_MASTER.md 실제 매장 정보 입력 (면적, Zone, 집기 수량)
2. 시즌별 작업 기록 입력 (과거 시즌 3개)
3. 매장 사진 업로드 후 Visual Director 첫 분석 실행
```

---

## ⚠️ 경고 / 블로커
```
- 매장 기본 정보 미입력 (VMD_MASTER.md ○○ 항목들)
- 시즌 기록 없음 (seasons/ 폴더 비어있음)
```

---

> 업데이트 규칙: 완료 항목은 날짜와 함께 "완료된 작업"으로 이동
