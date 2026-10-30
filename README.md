# codex-kit

시간 제한이 있는 실무형 과제(AI-assisted coding)를 Codex CLI로 진행할 때 쓰는 가벼운 작업 규칙과 Skill 모음이다.
과제별 코드는 포함하지 않는다. 계획, 요구사항 합의, 검증, 제출 점검 절차만 담는다.

## Install (30 sec)

작업 workspace root에서 실행한다. kit은 `/tmp`에 clone해서 제출물에 섞이지 않게 한다.

```bash
git clone https://github.com/ChangYeongJeong1103/codex-kit /tmp/codex-kit
/tmp/codex-kit/install.sh .
git add AGENTS.md .agents && git commit -m "chore: add working agreement (codex-kit)"
codex          # then /skills to confirm
```

kit 설치를 첫 commit으로 분리해 두면, 미리 준비한 작업 규칙과 과제 중 작업이 git history에서 구분된다.

Skill이 `/skills`에 보이지 않으면 `/tmp/codex-kit/install.sh . --user`로 다시 실행한다.

## What's inside

| Path | 역할 |
|---|---|
| `AGENTS.md` | Codex가 자동으로 읽는 작업 규칙: 먼저 확인하기, 작은 end-to-end 흐름, 단계별 검증, slice마다 commit, `0.0.0.0` bind |
| `skills/intake` | 업무 담당자에게 물어볼 질문 순서와 `REQUIREMENTS.md` / `DECISIONS.md` template |
| `skills/submit-check` | 제출 전 점검(clean start, 요구사항 대조, repo 정리)과 follow-up 질문 대비 메모 |
| `install.sh` | 위 파일을 workspace의 `AGENTS.md`와 `.agents/skills/`로 복사 |

## How to use during a task

1. `$intake` — README를 요약하고 담당자에게 물어볼 질문 2–3개를 받는다.
2. 가장 작은 end-to-end 흐름부터 구현하고, slice마다 run → test → commit.
3. 마감 15분 전 `$submit-check`.
