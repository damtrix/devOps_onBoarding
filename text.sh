#!/bin/bash
# Script to onboard new staff into our server for usage
userfiles=$(cat names.csv)

for user in $userfiles:
    do
    if id "$user"  &>/dev/null
    then
    echo "User exit already"
    else
    echo "$user"
    fi
done