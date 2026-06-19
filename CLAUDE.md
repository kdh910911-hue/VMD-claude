# VMD Ops — CLAUDE.md

## 참조 구조
```
CLAUDE.md          ← 이 파일. 작업 규칙 & 프로토콜 (자동 로드)
VMD_MASTER.md      ← 매장 핵심 레퍼런스 (모든 작업의 기준점)
memory/            ← 세션 간 연속성 유지
```
@.claude/context_routing.md
@.claude/agent_routing.md
@.claude/propagation_rules.md

> ⚠️ MD 파일 120줄 초과 시 경고 후 분할/압축 방향 제안

---

## 세션 프로토콜

### 시작 시 (생략 금지)
1. `memory/progress.md` — 현재 진행상황 + 경고 확인
2. `memory/decisions.md` — 이전 확정 결정사항 확인
3. `VMD_MASTER.md` — **항상 필수 로드**. 이 파일 없이 매장 작업 금지.

### 종료 전
- `memory/progress.md` — 완료 작업 이동, 다음 우선순위 업데이트
- `memory/decisions.md` — 새로 확정된 결정사항 추가
- `VMD_MASTER.md` — 매장/시즌 정보 변경 시 해당 섹션 갱신

---

## 매장 기본 정보
```
브랜드: SPAO 키즈 / 담당자: 김다현
담당 매장: ○○점 / 면적: ○○평 / 담당 기간: (입력 필요)
Zone A — 골든존(입구~3m) / Zone B — 메인 월
Zone C — 중앙 / Zone D — 코너
집기: 행거 ○개, 테이블 ○개, 마네킹 ○개, 선반 ○개
키즈 눈높이 기준: 90–120cm
```

## 타깃 구조
```
구매결정권자: 부모(30–40대) — 신뢰, 품질, 가성비
착용자: 아동(5–12세) — 호기심, 재미, 본인 선택 욕구
원칙: 성인 눈높이(155cm~)로 무드, 키즈 눈높이(90–120cm)로 체험
```

---

## 에이전트 5인 (.claude/agents/)
| 에이전트 | 파일 | 핵심 역할 |
|---------|------|----------|
| Visual Director | visual-director.md | 매장 사진 분석 + Higgsfield 프롬프트 |
| Space Planner | space-planner.md | 동선/배치 기획 + 도면 생성 명령 |
| Trend Researcher | trend-researcher.md | 글로벌 트렌드 서치 + 경쟁사 분석 |
| Season Planner | season-planner.md | 시즌 기획 문서 → seasons/[시즌]/plan.md |
| Feedback Coach | feedback-coach.md | 리스크 검증 + 회고 → seasons/[시즌]/record.md |

---

## 폴더 구조
```
D:\0.vmd ops\
├── CLAUDE.md / VMD_MASTER.md
├── .claude\agents\          ← 에이전트 5인 MD
├── seasons\[시즌]\
│   ├── photos\              ← Before/After 사진
│   ├── plans\               ← 도면, 기획 문서
│   └── record.md            ← 회고 (Feedback Coach)
├── references\trends|competitors\
└── higgsfield\              ← 프롬프트 + 생성 이미지
```

---

## 시즌 사이클
```
3주 전: Trend Researcher → 트렌드 서치
2주 전: Season Planner  → 기획안 작성
        Visual Director → 현매장 분석 + Higgsfield
1주 전: Space Planner   → 배치 도면
        Feedback Coach  → 리스크 검증
당  일: Space Planner   → 도면 최종 확인
완료 후: Feedback Coach → 회고 + record.md 저장
```

---

## 자주 쓰는 명령
```
"Visual Director, 이 사진 분석해줘. 개선점 TOP 3"
"Space Planner, Zone A 신학기 배치안 3가지"
"Trend Researcher, 2025 SS 키즈 글로벌 트렌드 TOP 5"
"Season Planner, 2025 SS 신학기 기획안 만들어줘"
"Feedback Coach, [변경 내용] 리스크 있어?"
"Feedback Coach, [시즌명] 회고 정리해줘"
```
