---
name: submit-check
description: Use about 15 minutes before the deadline, before confirming the submission. Verifies the app runs from a clean start, checks requirements coverage, cleans the repo, and checks that the user can explain the key code and failure paths without AI.
---

# Submit check

**제출을 확정하기 전에만 실행한다.** 제출 후 follow-up 질문에는 AI 없이 답해야 한다.

## 1. Works from a clean start
- 서버를 재시작하고 README의 실행 방법 그대로 실행되는지 확인한다.
- 핵심 흐름 1개를 처음부터 끝까지 직접 실행한다 (browser preview 또는 `curl`).
- 프로젝트의 기존 test 명령을 실행한다. 새 Python 프로젝트면 `pytest -q`.

## 2. Requirements coverage
- `REQUIREMENTS.md`의 각 항목을 ✅ / ⚠️ / ❌ 표로 정리한다.
- ❌와 ⚠️는 README의 "Known limitations"에 아래 3단계 형식으로 적는다:
  **약점 지점 → 왜 위험한지 (파급) → 다음에 무엇을 검증·개선할지**

## 3. Repo hygiene
- `README.md`: 목적, 실행 방법, 구조, Known limitations (짧게).
- debug print, 임시 파일, secret이 남아 있지 않은지 확인한다.
- 마지막 `git commit` (검증 근거 한 줄 포함).

## 4. Self-explanation check
답을 대신 써 주지 않는다. 대신 user가 직접 설명해야 할 지점을 짚어 준다.
**채팅에만 출력하고 파일로 만들지 않는다.**

- 핵심 코드 위치 3–5곳 (`file:function`)과 각각 한 줄 역할. user가 열어서 직접 읽어 보게 한다.
- 주요 실패 경로 2–3개: 어떤 입력이나 상황에서 깨지는지, 현재 어떻게 처리되는지.
- 아래 질문 목록을 보여 주고, user가 소리 내어 답해 볼 수 있게 한다. 약점 질문은 **약점 → 파급 → 다음 검증·개선** 순서로 답하도록 안내한다.
  - 전체 구조와 data flow는?
  - 가장 중요한 설계 결정, 그 이유, 버린 대안은?
  - 요구사항을 어떻게 해석했고 담당자와 무엇을 합의했나?
  - LLM output이 틀리면 어떻게 감지하고 대응하나?
  - 가장 약한 지점은 어디이고, 시간이 더 있었다면 무엇을 검증했나?
  - Codex를 어떻게 활용했고 그 결과를 어떻게 검증했나?
