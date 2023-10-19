#!/bin/bash
# Script to onboard new staff into our server for usage
userfiles=$(cat names.csv)
PASSWORD=PASSWORD


if [ $(id -u) -eq 1000 ]; then
     

    for user in $userfiles:
        do
            echo "$user"
        if id "$user"  &>/dev/null
        then
        echo "User Exist"
        else
            useradd -m -d /home/$user -s /bin/bash -g developers $user
            echo "New User Created"
            echo

            su - -c "mkdir ~/.ssh" $user
            echo ".ssh directory created for new user"
            echo

            su - -c "chmod 700 ~/.ssh" $user
            echo "User permission for .ssh directory set"


            su - -c "touch ~/.ssh/authorized_keys/" $user
            echo "Authorized key file created"
            echo

            su - -c "chmod 700 ~/.ssh/authorized_keys" $user
            echo "User authorized key permission set"
            echo

            cp "~/Shell/id_rsa.pub" "/home/$user/.ssh/authorized_keys"
            echo "Copied the public key into the Users Account on the server"
            echo

            echo "User created"

            sudo echo -e "PASSWORD\n$PASSWORD" | sudo passwd "$user"
            sudo passwd -x 5 $user
        fi
    done
else
echo "Only Admin can onBoard User"
fi