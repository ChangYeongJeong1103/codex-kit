# Working Agreement for Codex

이 workspace는 시간 제한(약 3h)이 있는 실무형 과제다.
요구사항은 별도 채팅의 **업무 담당자 (stakeholder)** 에게서 온다. Codex는 그 채팅을 볼 수 없으므로 user를 통해서만 요구사항을 받는다.

**우선순위: 플랫폼 규정 > 과제 README·기존 지침 > 이 문서.** 충돌하면 위의 것을 따른다.

## Priorities
1. **Clarify before build** — 요구사항이 모호하면 추측하지 말고, 담당자에게 물어볼 질문 2–3개를 제안한다. (`$intake` skill)
2. **One small, complete flow first** — 기능을 넓게 벌리지 말고 핵심 user flow 하나를 end-to-end로 먼저 동작시킨 뒤 확장한다.
3. **Verify each stage** — API 응답, parsing 결과, LLM output 같은 중간 결과를 실제로 실행해서 확인한 뒤 다음 단계로 간다. "될 것 같다"로 넘어가지 않는다.
4. **No unrequested features** — `REQUIREMENTS.md`에 없는 기능은 추가 전에 먼저 묻는다.

## Workflow
- 작업 단위(slice)는 20–40분. 각 slice 끝에서: run → test → `git commit`.
  Commit message 마지막 줄에 검증 근거를 남긴다. 예: `verified: pytest 5 passed, curl /api/plan → 200`
- 설계 결정과 trade-off는 `DECISIONS.md`에 즉시 1–2줄로 기록한다 (why / alternatives / limits / verified by).
- 제출 전에는 `$submit-check` skill을 사용한다.
- `$intake`, `$submit-check`가 동작하지 않으면 `.agents/skills/<name>/SKILL.md`를 직접 읽고 그 절차를 따른다.

## Tech defaults (과제가 다르게 요구하면 과제를 따른다)
- Python + FastAPI + 순수 HTML/JS (build step 없음).
- 서버는 반드시 `0.0.0.0`에 bind (IDE browser preview용): `uvicorn app:app --host 0.0.0.0 --port 8000 --reload`
- **Deterministic core**: 판정, 계산, ranking, filtering은 code로 한다. LLM은 설명, 요약, 초안 작성만 맡는다.
- LLM을 호출하면 JSON output을 요청하고 pydantic schema로 validate한다. 실패하면 1회 retry 후 fallback 응답을 쓴다.
- App에서 쓸 LLM API key가 env var에 있는지 시작할 때 확인한다. 없으면 fallback이 main path가 되므로 user에게 알린다.
- API key 같은 secret은 env var로만 다루고 코드나 git에 넣지 않는다.
- Tests: 기존 프로젝트의 test 명령을 우선한다. 새 Python 프로젝트면 pytest로 핵심 logic 위주로 소수만.

## Communication
- 답변은 짧게. 변경 요약은 "무엇을 / 왜 / 어떻게 확인했는지" 3줄 이내.
- 큰 파일을 반복해서 통째로 읽지 말고 필요한 부분만 읽는다 (token 효율).
- 확신이 없으면 확신이 없다고 말한다.
