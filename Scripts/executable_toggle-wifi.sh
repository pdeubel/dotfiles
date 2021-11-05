#!/bin/bash

var="$(nmcli radio wifi)" 

if [[ $var =~ "enabled" ]]; then
    nmcli radio wifi off
    echo "now disabled"
else
    nmcli radio wifi on
    echo "now enabled"
fi

