#!/usr/bin/env bash

source progress_bar.sh

PROGRESS_BAR_ACCENT=4

progress_init 2

echo "Welcome"

progress test
echo "Sleeping 2 seconds..."
sleep 2

progress test2
echo "Sleeping 3 seconds..."
sleep 3

progress "Done!"
sleep 1

progress_destroy

echo EOF
