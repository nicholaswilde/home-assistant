#!/usr/bin/env bash
set -euo pipefail

# Safely pull latest base branch on the remote Raspberry Pi Home Assistant host,
# preserving tracked local overrides (e.g. compose.yaml network_mode, ha/configuration.yaml),
# validate Docker Compose config, and run `task update`.

REMOTE_HOST="${HA_REMOTE_HOST:-nicholas@192.168.1.88}"
REMOTE_DIR="${HA_REMOTE_DIR:-/home/nicholas/git/nicholaswilde/home-assistant}"
BASE_BRANCH="${HA_BASE_BRANCH:-main}"
SKIP_UPDATE="false"

usage() {
  cat <<'EOF'
Usage: update-remote.sh [options]

Options:
  --host <user@host>   Remote SSH target (default: nicholas@192.168.1.88 or $HA_REMOTE_HOST)
  --dir <remote_dir>   Remote repo path (default: /home/nicholas/git/nicholaswilde/home-assistant or $HA_REMOTE_DIR)
  --branch <branch>    Branch to pull on remote (default: main or $HA_BASE_BRANCH)
  --skip-update        Pull, re-apply local overrides, and validate config without running task update
  -h, --help           Show this help message
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
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
    --branch)
      [[ $# -ge 2 ]] || { echo "ERROR: --branch requires a value" >&2; exit 1; }
      BASE_BRANCH="$2"
      shift 2
      ;;
    --skip-update)
      SKIP_UPDATE="true"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

echo "Updating remote instance on $REMOTE_HOST ($REMOTE_DIR, branch: $BASE_BRANCH)..."

ssh -o BatchMode=yes -o ConnectTimeout=10 "$REMOTE_HOST" bash -s -- "$REMOTE_DIR" "$BASE_BRANCH" "$SKIP_UPDATE" <<'EOF'
set -euo pipefail

REMOTE_DIR="$1"
BASE_BRANCH="$2"
SKIP_UPDATE="$3"

cd "$REMOTE_DIR"

CURRENT_BRANCH=$(git branch --show-current)
if [[ "$CURRENT_BRANCH" != "$BASE_BRANCH" ]]; then
  echo "ERROR: Remote repo is on branch '$CURRENT_BRANCH', expected '$BASE_BRANCH'." >&2
  exit 1
fi

STASHED="false"
if ! git diff --quiet || ! git diff --staged --quiet; then
  git stash push -m "pre-update-remote-$(date +%Y%m%d-%H%M%S)"
  STASHED="true"
fi

restore_stash() {
  if [[ "$STASHED" == "true" ]]; then
    git stash pop >/dev/null 2>&1 || echo "WARNING: Failed to auto-restore stash; check 'git stash list' in $REMOTE_DIR." >&2
  fi
}
trap restore_stash ERR

git fetch origin "$BASE_BRANCH"
git pull --ff-only origin "$BASE_BRANCH"
trap - ERR

if [[ "$STASHED" == "true" ]]; then
  if ! git stash pop; then
    echo "ERROR: Conflict popping local overrides on $(hostname). Stash preserved; inspect 'git stash list' in $REMOTE_DIR." >&2
    exit 4
  fi
fi

docker compose config --quiet

if [[ "$SKIP_UPDATE" != "true" ]]; then
  task update
fi

docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"
EOF
