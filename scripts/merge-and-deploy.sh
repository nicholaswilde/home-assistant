#!/usr/bin/env bash
set -euo pipefail

# Merge an open GitHub PR into the base branch, push to origin, verify PR state,
# and update the remote Raspberry Pi Home Assistant instance via update-remote.sh.

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

PR_NUMBER=""
BASE_BRANCH=""
STRATEGY="merge"
REMOTE_HOST=""
REMOTE_DIR=""
NO_DEPLOY="false"

usage() {
  cat <<'EOF'
Usage: merge-and-deploy.sh [options] <pr_number>

Arguments:
  <pr_number>          Numeric GitHub PR number (leading '#' optional)

Options:
  --pr <number>        Numeric GitHub PR number
  --base <branch>      Target base branch (defaults to PR base branch, fallback: main)
  --merge              Use --no-ff merge commit (default)
  --squash             Squash-merge PR into base branch
  --host <user@host>   Override remote SSH host passed to update-remote.sh
  --dir <remote_dir>   Override remote repo dir passed to update-remote.sh
  --no-deploy          Merge and push only; skip remote instance update
  -h, --help           Show this help message
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --pr)
      [[ $# -ge 2 ]] || { echo "ERROR: --pr requires a value" >&2; exit 1; }
      PR_NUMBER="$2"
      shift 2
      ;;
    --base)
      [[ $# -ge 2 ]] || { echo "ERROR: --base requires a value" >&2; exit 1; }
      BASE_BRANCH="$2"
      shift 2
      ;;
    --merge)
      STRATEGY="merge"
      shift
      ;;
    --squash)
      STRATEGY="squash"
      shift
      ;;
    --host)
      [[ $# -ge 2 ]] || { echo "ERROR: --host requires a value" >&2; exit 1; }
      REMOTE_HOST="$2"
      shift 2
      ;;
    --dir)
      [[ $# -ge 2 ]] || { echo "ERROR: --dir requires a value" >&2; exit 1; }
      REMOTE_DIR="$2"
      shift 2
      ;;
    --no-deploy)
      NO_DEPLOY="true"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    -*)
      echo "ERROR: Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
    *)
      if [[ -z "$PR_NUMBER" ]]; then
        PR_NUMBER="$1"
      else
        echo "ERROR: Unexpected argument: $1" >&2
        usage >&2
        exit 1
      fi
      shift
      ;;
  esac
done

PR_NUMBER="${PR_NUMBER#\#}"
if [[ -z "$PR_NUMBER" || ! "$PR_NUMBER" =~ ^[0-9]+$ ]]; then
  echo "ERROR: Valid numeric PR number required." >&2
  usage >&2
  exit 1
fi

command -v git >/dev/null 2>&1 || { echo "ERROR: git is required." >&2; exit 1; }
command -v gh >/dev/null 2>&1 || { echo "ERROR: gh CLI is required." >&2; exit 1; }

REPO_ROOT=$(git rev-parse --show-toplevel)
cd "$REPO_ROOT"

if ! git diff --quiet || ! git diff --staged --quiet; then
  echo "ERROR: Working tree has tracked uncommitted changes. Commit or stash before merging." >&2
  exit 2
fi

IFS=$'\t' read -r PR_STATE HEAD_BRANCH PR_BASE PR_TITLE < <(
  gh pr view "$PR_NUMBER" --json state,headRefName,baseRefName,title \
    --jq '[.state, .headRefName, .baseRefName, .title] | @tsv' | cat
)

if [[ "$PR_STATE" != "OPEN" ]]; then
  echo "ERROR: PR #$PR_NUMBER is not OPEN (current state: $PR_STATE)." >&2
  exit 1
fi

BASE_BRANCH="${BASE_BRANCH:-${PR_BASE:-main}}"

echo "Fetching origin/$BASE_BRANCH and origin/$HEAD_BRANCH..."
git fetch origin "$BASE_BRANCH"
git fetch origin "$HEAD_BRANCH"

git checkout "$BASE_BRANCH"
git pull --ff-only origin "$BASE_BRANCH"

echo "Merging PR #$PR_NUMBER ($HEAD_BRANCH) into $BASE_BRANCH ($STRATEGY)..."
if [[ "$STRATEGY" == "squash" ]]; then
  if ! git merge --squash "origin/$HEAD_BRANCH"; then
    echo "ERROR: Merge conflicts detected in:" >&2
    git diff --name-only --diff-filter=U >&2
    exit 3
  fi
  git commit -m "$PR_TITLE (#$PR_NUMBER)"
else
  MERGE_MSG="Merge pull request #$PR_NUMBER from $HEAD_BRANCH"$'\n\n'"$PR_TITLE"
  if ! git merge "origin/$HEAD_BRANCH" --no-ff -m "$MERGE_MSG"; then
    echo "ERROR: Merge conflicts detected in:" >&2
    git diff --name-only --diff-filter=U >&2
    exit 3
  fi
fi

echo "Pushing $BASE_BRANCH to origin..."
git push origin "$BASE_BRANCH"

FINAL_STATE="OPEN"
for _ in 1 2 3; do
  FINAL_STATE=$(gh pr view "$PR_NUMBER" --json state --jq .state | cat)
  if [[ "$FINAL_STATE" != "OPEN" ]]; then
    break
  fi
  sleep 2
done

if [[ "$FINAL_STATE" == "OPEN" && "$STRATEGY" == "squash" ]]; then
  gh pr close "$PR_NUMBER" --comment "Merged into $BASE_BRANCH" | cat
  FINAL_STATE="CLOSED"
fi

echo "PR #$PR_NUMBER state: $FINAL_STATE"

git branch -d "$HEAD_BRANCH" 2>/dev/null || true

if [[ "$NO_DEPLOY" == "true" ]]; then
  echo "Skipping remote deployment (--no-deploy)."
  exit 0
fi

DEPLOY_ARGS=(--branch "$BASE_BRANCH")
if [[ -n "$REMOTE_HOST" ]]; then
  DEPLOY_ARGS+=(--host "$REMOTE_HOST")
fi
if [[ -n "$REMOTE_DIR" ]]; then
  DEPLOY_ARGS+=(--dir "$REMOTE_DIR")
fi

exec "$SCRIPT_DIR/update-remote.sh" "${DEPLOY_ARGS[@]}"
