#!/bin/bash
userfiles=$(cat names.csv)

for user in $userfiles:
    do
        if id "$user" &>/dev/null
        then
        userdel -r $user
        echo "$user removed"
        else
        echo "$user doesn't Exist"
        fi
done
