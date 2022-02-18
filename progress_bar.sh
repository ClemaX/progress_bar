#!/usr/bin/env bash

PROGRESS_BAR_LINES=2

progress_init_scroll()
{
	# Current terminal height
	PROGRESS_LINES=$(tput lines)

	PROGRESS_SCROLL_LINES=$((PROGRESS_LINES - PROGRESS_BAR_LINES))

	# Scroll one line to avoid visual glitch when shrinking by one row
	echo

	# Save cursor position
	tput sc

	# Set scroll region (and move cursor to the top-left corner)
	tput csr 0 "$PROGRESS_SCROLL_LINES"

	# Restore cursor position
	tput rc

	# Move the cursor up into the scroll-region
	tput cup "$((PROGRESS_SCROLL_LINES - 1))" 0

	progress_bar
}

progress_init() # step_count
{
	PROGRESS_TOTAL="$1"
	PROGRESS_CURR=0

	progress_init_scroll

	echo "total lines: $PROGRESS_LINES"
	echo "scroll lines: $PROGRESS_SCROLL_LINES"
	echo "bar lines: $PROGRESS_BAR_LINES"
}

progress_bar() # [step_name]
{
	local step_name="${1:-}"

	# Save cursor position
	tput sc

	# Go to the progress-bar region
	tput cup "$((PROGRESS_SCROLL_LINES + 1))" 0

	# Clear progress-bar
	tput ed

	# Print progress-bar
	echo -n "progress: $PROGRESS_CURR/$PROGRESS_TOTAL: $step_name"

	# Restore cursor position
	tput rc
}

progress() # [step_name]
{
	local step_name="${1:-}"

	if [ "$(tput lines)" -ne "$PROGRESS_LINES" ]
	then
		progress_init_scroll
	fi

	if [ "$PROGRESS_CURR" -lt "$PROGRESS_TOTAL" ]
	then
		((PROGRESS_CURR += 1))

		progress_bar "$step_name"
	fi
}

progress_init 2

echo "Welcome"

progress test
echo "Sleeping 2 seconds..."
sleep 2

progress test2
echo "Sleeping 3 seconds..."
sleep 3

echo "Done!"

tput rmcup
