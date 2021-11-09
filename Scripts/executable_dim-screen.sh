#!/bin/bash

# Example notifier script -- lowers screen brightness, then waits to be killed
# and restores previous brightness on exit.

## CONFIGURATION ##############################################################

# Brightness will be lowered to this value.
min_brightness=20

# If your video driver works with xbacklight, set -time and -steps for fading
# to $min_brightness here. Setting steps to 1 disables fading.
fade_time=200
fade_steps=20

# If you have a driver without RandR backlight property (e.g. radeon), set this
# to use the sysfs interface and create a .conf file in /etc/tmpfiles.d/
# containing the following line to make the sysfs file writable for group
# "users":
#
#     m /sys/class/backlight/acpi_video0/brightness 0664 root users - -
#
#sysfs_path=/sys/class/backlight/acpi_video0/brightness

# Time to sleep (in seconds) between increments when using sysfs. If unset or
# empty, fading is disabled.
fade_step_time=0.05

###############################################################################

get_brightness() {
    light -G
}

set_brightness() {
    light -S $1
}

fade_brightness() {   
    local level
    for level in $(eval echo {$(get_brightness)..$1}); do
        echo $level
	set_brightness $level
        sleep $fade_step_time
    done
}

trap 'exit 0' TERM INT
trap "set_brightness $(get_brightness); kill %%" EXIT
# fade_brightness $min_brightness
set_brightness $min_brightness
sleep 2147483647 &
wait
