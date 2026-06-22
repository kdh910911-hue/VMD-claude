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

## 에이전트 6인 (.claude/agents/)
| 에이전트 | 파일 | 핵심 역할 |
|---------|------|----------|
| Guide Maker | guide-maker.md | 월별 VMD 가이드 + 진열맵 제작 → guides/YYYY/YYYY-MM_가이드.md |
| Open Planner | open-planner.md | 신규 매장 오픈 레이아웃 기획 + 비용 관리 |
| VP Stylist | vp-stylist.md | VP Zone 기획 + 시즌 광고 착장 코디 |
| Rounding Checker | rounding-checker.md | 라운딩 체크리스트 + 즉각 개선안 → rounding/ |
| Education Editor | education-editor.md | 직원 VMD 교육 자료 제작 → education/ |
| Visual Director | visual-director.md | 매장 사진 분석 + 컬러/볼륨/포컬포인트 평가 |

---

## 폴더 구조
```
D:\0.vmd ops\
├── CLAUDE.md / VMD_MASTER.md
├── .claude\agents\          ← 에이전트 6인 MD
├── guides\YYYY\             ← 월별 VMD 배포 가이드 아카이브
├── openings\YYYY\           ← 신규 매장 오픈 레이아웃 + 비용
├── rounding\YYYY-MM\        ← 매장 라운딩 보고서
└── education\YYYY\          ← 직원 VMD 교육 자료
```

---

## 월별 업무 사이클
```
월초  : Guide Maker    → 이달의 VMD 가이드 + 진열맵 초안
        VP Stylist     → 이달의 VP Zone + 광고 착장 코디
        Education Editor → 가이드 설명 교육 자료
라운딩: Visual Director → 매장 사진 분석
        Rounding Checker → 체크리스트 점검 + 즉각 개선안
오픈  : Open Planner   → 레이아웃 기획 + 비용 산출
```

---

## 자주 쓰는 명령
```
"Guide Maker, 이번 달 VMD 가이드 초안 만들어줘"
"VP Stylist, 이달 VP Zone 마네킹 착장 기획해줘"
"Rounding Checker, 이 사진 보고 라운딩 체크해줘"
"Visual Director, 이 사진 분석해줘. 개선점 TOP 3"
"Open Planner, ○○점 오픈 레이아웃 만들어줘"
"Education Editor, 이번 달 가이드 설명 자료 만들어줘"
```
