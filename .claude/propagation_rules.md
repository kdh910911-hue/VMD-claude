# Propagation Rules

> 파일 A를 수정할 때 반드시 함께 확인/업데이트해야 할 파일을 정의한다.
> 외과적 수정 원칙: 요청된 파일만 수정. 단, 아래 전파 규칙은 예외.

---

## 전파 규칙 테이블

| 수정 파일 | 함께 확인/업데이트 |
|---------|-----------------|
| `VMD_MASTER.md` — 매장 기본 정보 변경 | `CLAUDE.md` 매장 기본 정보 동기화 |
| `VMD_MASTER.md` — 시즌 캘린더 변경 | `memory/progress.md` 현재 시즌 확인 |
| `seasons/[시즌]/plan.md` 신규 생성 | `VMD_MASTER.md` 섹션 4(시즌별 기록) 요약 추가 |
| `seasons/[시즌]/record.md` 완성 | `VMD_MASTER.md` 시즌 결과 요약 업데이트, `memory/decisions.md` 인사이트 추가 |
| `.claude/agents/` 에이전트 파일 수정 | `CLAUDE.md` 에이전트 테이블 설명 일치 확인 |
| `memory/decisions.md` 새 결정 추가 | `memory/progress.md` 관련 항목 반영 |
| `higgsfield/PROMPTS.md` 프롬프트 추가 | 출처 시즌 기록에 ★ 표시 권장 |

---

## 금지 사항
- 전파 규칙 없는 파일을 임의로 "같이 정리"하는 행위 금지
- `memory/decisions.md` 기존 항목 수정 금지 (추가만 허용)
- `VMD_MASTER.md` 섹션 1–3은 실제 매장 변경 시에만 수정
