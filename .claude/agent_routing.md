# Agent Routing Rules

> 요청 유형에 따라 어떤 에이전트를 호출할지 정의한다.
> 명시적 호출 없어도 요청 내용으로 판단해 자동 라우팅.

---

## 키워드 → 에이전트 매핑

| 요청 키워드/유형 | 자동 호출 에이전트 |
|---------------|-----------------|
| 가이드, 진열맵, 배포, 이달의 가이드 | Guide Maker |
| 오픈, 신규 매장, 레이아웃, 평당 비용, 세금계산서 | Open Planner |
| VP Zone, 마네킹 착장, 키룩, 광고 착장, 코디 | VP Stylist |
| 라운딩, 점검, 체크리스트, 가이드 준수, 문제점 | Rounding Checker |
| 교육, 직원 교육, 교육 자료, 온보딩 | Education Editor |
| 사진 분석, 컬러, 볼륨, 포컬포인트 | Visual Director |

---

## 복합 요청 처리 순서

```
라운딩 현장 요청
  → Visual Director 먼저 (사진 분석)
  → Rounding Checker 후 (체크리스트 + 즉각 개선안)

월초 가이드 준비 요청
  → Guide Maker (진열맵 + 실행 가이드 초안)
  → VP Stylist (VP Zone + 착장 코디)
  → Education Editor (가이드 설명 자료)

신규 매장 오픈 요청
  → Open Planner (레이아웃 기획 + 비용 산출)
  → Visual Director (오픈 후 사진 분석)
```

---

## 에이전트 파일 위치
`.claude/agents/` 폴더 내 각 에이전트 MD 참조

---

## 라우팅 원칙
- 방향 불명확 시 임의 진행 금지 — VMD_MASTER.md 먼저 로드 후 확인
- "무엇을 도와드릴까요?" 금지 — "Zone A 분석이 필요해 보이는데 Visual Director로 바로 시작할까요?" 형태로
