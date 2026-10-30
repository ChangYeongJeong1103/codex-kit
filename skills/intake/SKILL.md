---
name: intake
description: Use at the start of a task or whenever requirements are vague. Turns the task README and the stakeholder's (업무 담당자) answers into short clarifying questions and a REQUIREMENTS.md agreement.
---

# Intake: 요구사항 합의

목표: 10–15분 안에 "무엇을 만들고, 어떻게 되면 성공인지"를 합의한다.

## Steps
1. 과제 README와 제공 파일(data, starter code)을 훑고 5줄 이내로 요약한다: 사용자, 문제, 입력/출력, 제약.
2. 빈칸을 찾아 담당자에게 보낼 질문을 만든다. **한 번에 2–3개**, 아래 우선순위대로:
   - **Who / Goal**: 주 사용자는 누구이고, 지금 가장 불편한 점은?
   - **Success**: 데모에서 무엇이 보이면 "됐다"고 할 수 있나? (구체적 시나리오 1개)
   - **Must vs Nice**: 꼭 필요한 것 vs 있으면 좋은 것
   - **Data / Constraints**: 데이터 형식과 규모, 사용 가능한 API·model, 금지 사항
   - **Out of scope**: 이번에 하지 않아도 되는 것
3. 질문은 짧고 구체적으로, 예/아니오나 선택지로 답할 수 있게 쓴다. 담당자는 한 번에 다 알려주지 않으므로 답을 받으면 follow-up 질문을 이어간다.
4. 답을 받으면 이 skill 폴더의 `templates/REQUIREMENTS.template.md` 형식으로 workspace root에 `REQUIREMENTS.md`를 만들거나 갱신한다.
   담당자 답변은 시각과 함께 `Stakeholder Q&A`에 한 줄씩 요약한다 (대화와 문서를 연결하는 근거).
   `DECISIONS.md`가 없으면 `templates/DECISIONS.template.md`로 함께 만든다.
5. 첫 slice(가장 작은 end-to-end 흐름)를 제안하고, 담당자에게 확인받을 한 줄 요약을 만든다.

## Rules
- README에 이미 답이 있는 것은 묻지 않는다.
- 답을 기다리는 동안 할 수 있는 일(project skeleton, data loading 확인)을 제안한다.
- 요구사항이 바뀌면 `REQUIREMENTS.md`의 Change log에 기록한다.
