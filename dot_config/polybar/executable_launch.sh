#!/usr/bin/env bash

LOG_FILE_1=/tmp/polybar1.log
LOG_FILE_2=/tmp/polybar2.log

# Terminate already running bar instances

killall -q polybar

# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Remove log files if they exist

[ -e $LOG_FILE_1 ] && rm $LOG_FILE_1
[ -e $LOG_FILE_2 ] && rm $LOG_FILE_2

# Launch bar1 and bar2

polybar top >> $LOG_FILE_1 2>&1 &
polybar bottom >> $LOG_FILE_2 2>&1 &


echo "Bars launched..."
