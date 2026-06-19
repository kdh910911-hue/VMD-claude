# Agent Routing Rules

> 요청 유형에 따라 어떤 에이전트를 호출할지 정의한다.
> 명시적 호출 없어도 요청 내용으로 판단해 자동 라우팅.

---

## 키워드 → 에이전트 매핑

| 요청 키워드/유형 | 자동 호출 에이전트 |
|---------------|-----------------|
| 사진 분석, 컬러, 볼륨, 포컬포인트 | Visual Director |
| AI 시뮬레이션, 무드보드, Before/After, Higgsfield 프롬프트, 시각화, 프롬프트 설계 | AI VMD Creator |
| 배치, 동선, 도면, Zone 변경, 집기, 데드존 | Space Planner |
| 트렌드, 경쟁사, Zara Kids, H&M, 글로벌 | Trend Researcher |
| 시즌 기획, 테마, 컨셉, 컬러 팔레트, plan.md | Season Planner |
| 리스크, 대안, 회고, KPT, 다음 시즌 | Feedback Coach |

---

## 복합 요청 처리 순서

```
사진 분석 + 배치 변경 요청
  → Visual Director 먼저 (현황 파악)
  → Space Planner 후 (변경안 설계)
  → AI VMD Creator (Before/After 시뮬레이션 시각화)

시즌 준비 요청
  → Trend Researcher 먼저 (트렌드 인풋)
  → Season Planner 후 (기획 문서화)
  → AI VMD Creator (시즌 무드보드 + Higgsfield 프롬프트)

변경 완료 후 요청
  → Feedback Coach (회고 + record.md 저장)
```

---

## 에이전트 파일 위치
`.claude/agents/` 폴더 내 각 에이전트 MD 참조

---

## 라우팅 원칙
- 방향 불명확 시 임의 진행 금지 — VMD_MASTER.md 먼저 로드 후 확인
- "무엇을 도와드릴까요?" 금지 — "Zone A 분석이 필요해 보이는데 Visual Director로 바로 시작할까요?" 형태로
