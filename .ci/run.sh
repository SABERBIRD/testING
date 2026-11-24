#!/usr/bin/env bash
# Test fixture for ciDGET. Each workflow reads its mode from .ci/scenario.
#   pass   - succeeds
#   fail   - fails
#   slow   - runs ~15 min (stays yellow); re-run it to get yellow again
#   cancel - cancels its own run
#   flaky  - fails on attempt 1, passes on re-run (attempt 2+)
set -euo pipefail
wf="$1"
mode="$(grep -E "^${wf}=" .ci/scenario | cut -d= -f2 || true)"
mode="${mode:-pass}"
echo "workflow=${wf} mode=${mode} attempt=${ATTEMPT:-?}"
case "$mode" in
  pass)   echo "ok" ;;
  fail)   echo "intentional failure"; exit 1 ;;
  slow)   sleep "${SLOW_SECONDS:-900}"; echo "done" ;;
  cancel) gh run cancel "$GITHUB_RUN_ID" --repo "$GITHUB_REPOSITORY"; sleep 120 ;;
  flaky)  if [ "${ATTEMPT:-1}" = "1" ]; then echo "fails on first attempt"; exit 1; fi; echo "ok on re-run" ;;
  *)      echo "unknown mode: $mode"; exit 2 ;;
esac
