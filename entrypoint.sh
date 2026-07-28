#!/bin/sh
set -e

dir="$(printenv 'INPUT_WORKING-DIRECTORY' || true)"
if [ -n "$dir" ]; then
  cd "$dir"
fi

exec "$@"
