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
