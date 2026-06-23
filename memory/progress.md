# Progress — 현재 진행 상황

> 세션 시작 시 첫 번째로 읽는 파일.
> 매 세션 종료 전 반드시 업데이트.

---

## 현재 시즌
```
활성 시즌: 2026 7P (7월)
시즌 단계: 진열맵 제작 중
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

2026-06-22 — 에이전트 시스템 실무 6인으로 개편
             Guide Maker / Open Planner / VP Stylist /
             Rounding Checker / Education Editor / Visual Director
             CLAUDE.md + agent_routing.md 업데이트

2026-06-22 — guides/2026/ 폴더 구축 (1P~7P 전체)
             진열맵 PDF + 월간스파오 PDF 업로드 완료
             파일 검토: 3P 중복 파일 확인, 7P 월간스파오 누락 확인
             월간스파오 PDF는 100MB+ → .gitignore 처리 (로컬 전용 보관)

2026-06-22 — rounding/ 폴더 구축
             2026-06 6P: 고양스타필드 / 수원스타필드 / 용산아이파크몰 사진

2026-06-23 — 7P 단독 진열맵 claude.ai 프롬프트 작성 완료
             집기 스펙: H2600(6칸/4칸) + H1800 1단(6칸/4칸) + 하부장 350mm
             섹션 구성: TABLE(그래픽티) / MAIN(여아뉴스타일) / SUB(상하세트) / SSUB(산리오기획전)
             상품 코드 + 컬러 전체 반영한 프롬프트 완성
```

---

## 다음 우선순위
```
1. 7P 단독 진열맵 — claude.ai에서 완성 후 최종본 guides/2026/7P에 저장
2. 7P 인샵 진열맵 — 단독 완료 후 진행
3. rounding/2026-06 사진 — Visual Director로 분석 (3개 매장)
4. VMD_MASTER.md — 실제 매장 정보 입력 (면적/Zone/집기 수량)
5. 3P 중복 파일 정리 (1 버전 삭제 여부 다현님 확인 필요)
```

---

## ⚠️ 경고 / 블로커
```
- 3P 월간스파오 중복 파일: 각 버전 2개씩 존재 → 구버전 삭제 여부 확인 필요
- 7P 월간스파오 PDF 미수령 (진열맵만 있음)
- 월간스파오 PDF 전체 → GitHub 업로드 불가 (100MB+ 초과), 로컬만 보관
- VMD_MASTER.md 매장 기본 정보 미입력
```

---

> 업데이트 규칙: 완료 항목은 날짜와 함께 "완료된 작업"으로 이동
