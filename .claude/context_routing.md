# Context Routing Rules

> 어떤 작업 요청에 어떤 파일을 로드할지 정의한다.
> Claude는 작업 전 이 규칙을 확인하고 필요한 파일을 먼저 읽는다.

---

## 기본 로드 (모든 작업 공통)
- `VMD_MASTER.md` — 항상 필수. 이 파일 없이 매장 관련 작업 금지.
- `memory/progress.md` — 현재 시즌 진행상황 파악

---

## 작업 유형별 추가 로드

| 작업 유형 | 추가 로드 파일 |
|----------|--------------|
| 매장 사진 분석 | `VMD_MASTER.md` (Zone 구조 참조) |
| 시즌 기획 | `seasons/[시즌명]/plan.md` (이전 시즌 있으면 직전 시즌도) |
| 배치 변경안 | `seasons/[시즌명]/plan.md` + Zone 구조 |
| 트렌드 서치 | `references/trends/` + `references/competitors/` |
| 경쟁사 분석 | `references/competitors/` + `VMD_MASTER.md` |
| 시즌 회고 | `seasons/[시즌명]/plan.md` + `memory/decisions.md` |
| Higgsfield 프롬프트 | `higgsfield/PROMPTS.md` |
| 결정사항 확인 | `memory/decisions.md` |

---

## 로드 금지 규칙
- 요청과 무관한 시즌 파일 자동 로드 금지
- `memory/decisions.md` 내용을 임의로 수정 금지 (추가만 허용)
