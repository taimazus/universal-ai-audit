#!/usr/bin/env bash
set -euo pipefail
REF=main
REPOSITORY=https://github.com/taimazus/universal-ai-audit.git
while (($#)); do
  case "$1" in
    --ref|--repository)
      option="$1"
      [[ $# -ge 2 && -n "$2" && "$2" != -* ]] || { echo "Missing/invalid value for $option" >&2; exit 2; }
      shift
      if [[ "$option" == --ref ]]; then REF="$1"; else REPOSITORY="$1"; fi
      shift ;;
    --) shift; break ;;
    -h|--help)
      echo 'install-from-git.sh [--ref BRANCH_OR_TAG] [--repository TRUSTED_URL] -- [install.sh options]'
      exit 0 ;;
    *) echo 'Use -- before installer options.' >&2; exit 2 ;;
  esac
done
command -v git >/dev/null || { echo 'Git is required.' >&2; exit 1; }
CHECKOUT="$(mktemp -d "${TMPDIR:-/tmp}/universal-ai-audit.XXXXXX")"
echo "[FETCH] $REPOSITORY ref=$REF -> $CHECKOUT"
git clone --depth 1 --branch "$REF" -- "$REPOSITORY" "$CHECKOUT" || { echo 'Git clone failed; installation was not started.' >&2; exit 1; }
[[ -f "$CHECKOUT/install.sh" ]] || { echo 'Downloaded repository has no install.sh.' >&2; exit 1; }
echo "[SOURCE] $CHECKOUT (retained for inspection)"
# Preserve the caller's working directory so the default project target stays correct.
bash "$CHECKOUT/install.sh" "$@"
