# Decisions — 확정된 결정사항

> 한 번 기록된 항목은 수정 금지. 번복 시 새 항목으로 추가.
> 미확정 사항은 여기 기록 금지 — progress.md에 보류 표시.

---

## 시스템 결정

```
[2026-06-19] Claude Code 시스템 구축
  - 에이전트 5인: Visual Director, Space Planner, Trend Researcher,
                  Season Planner, Feedback Coach
  - 폴더 구조: seasons/ + references/ + higgsfield/ + memory/
  - 파일 크기 한도: 모든 MD 파일 120줄 초과 시 분할
  - 에이전트 위치: .claude/agents/ (Claude Code 공식 방식)

[2026-06-19] config-ops 레포 참조 → 자동화 시스템 고도화
  - check_size.py: PostToolUse(Edit|Write) 훅 — MD 파일 줄수 한도 자동 감시
    한도: VMD_MASTER 150줄 / CLAUDE.md 120줄 / decisions 80줄 / progress 100줄
  - block_binary_reads.py: PreToolUse(Read) 훅 — 바이너리/미디어 파일 자동 차단
    허용 방법: memory/.binary_read_allowlist 에 파일명 추가 (1회 소모)
  - Stop 훅 업그레이드: memory/backup/TIMESTAMP/ 자동 스냅샷, 최근 3개 유지
    + progress.md [x] 완료 항목 자동 정리
    + VMD_MASTER ↔ decisions 날짜 정합성 자동 감지 → progress.md 경고 추가

[2026-06-19] AI VMD Creator 에이전트 추가 (6번째 에이전트)
  - 역할: AI 시뮬레이션·무드보드·Before/After 시각화 + Higgsfield 프롬프트 설계
  - agent_routing.md 업데이트: Higgsfield 키워드 → AI VMD Creator 자동 라우팅
  - 시즌 사이클에 추가: 2주 전 Visual Director 분석 후 AI VMD Creator 시뮬레이션

[2026-06-19] Season Planner 에이전트 도입
  - Portfolio Editor 대체
  - 역할: 시즌 테마/컬러/Zone별 기획 문서 작성
  - 산출물: seasons/[시즌명]/plan.md

[2026-06-19] Higgsfield 프롬프트 분리
  - VMD_MASTER.md에서 분리 → higgsfield/PROMPTS.md
  - 이유: 파일 크기 한도 초과 (182줄 → 68줄로 압축)
```

---

## VMD 실무 결정
```
(시즌 작업하면서 채워나갈 것)
예시:
[YYYY-MM-DD] SS25 신학기 컨셉: ○○
[YYYY-MM-DD] Zone A 집기 구성 변경: 행거 3개 → 2개 + 테이블 1개
```
