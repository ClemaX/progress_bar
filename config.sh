#!/usr/bin/env bash

[ $# -lt 1 ] && echo "Usage: $0 file" >&2 && exit 1

PROGRESS_BAR_PREFIX_FW=0
PROGRESS_CURR=0

progress() # step_name
{
	local step_name="${1:-}"

	[ ${#step_name} -gt $PROGRESS_BAR_PREFIX_FW ] \
	&& PROGRESS_BAR_PREFIX_FW=${#step_name}

	((PROGRESS_CURR += 1))
}

progress_code=$(grep -o 'progress[[:space:]].*$' "$1")

eval "$progress_code"

echo "PROGRESS_BAR_PREFIX_FW=-$PROGRESS_BAR_PREFIX_FW"
echo "PROGRESS_TOTAL=$PROGRESS_CURR"
