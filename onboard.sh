#!/bin/bash
# Script to onboard new staff into our server for usage
userfiles=$(cat names.csv)
PASSWORD=PASSWORD

# To ensure the user running this script has sudo privilege
if [ $(id -u) -eq 0 ]; then

    # Reading the csv file
    for user in $userfiles
        do
            echo "$user"
        if id "$user"  &>/dev/null
        then
        echo "User Exist"
        else
            # This will create a new user
            useradd -m -d /home/$user -s /bin/bash -g developers $user
            echo "New User Created"
            echo
            # This will create a ssh folder in the user home folder
            su - -c "mkdir ~/.ssh" $user
            echo ".ssh directory created for new user"
            echo

            # We need to set the user permission for the ssh dir
            su - -c "chmod 700 ~/.ssh" $user
            echo "User permission for .ssh directory set"

            # This will create an authorized key file
            su - -c "touch ~/.ssh/authorized_keys" $user
            echo "Authorized key file created"
            echo

            #  We need to set the permission for the key file
            su - -c "chmod 700 ~/.ssh/authorized_keys" $user
            echo "User authorized key permission set"
            echo

            #  We need to create and set public key for users in the server
            cp "id_rsa.pub" "/home/$user/.ssh/authorized_keys"
            echo "Copied the public key into the Users Account on the server"
            echo

            echo "User created"
            
            # Generate a Password
            sudo echo -e "PASSWORD\n$PASSWORD" | sudo passwd "$user"
            sudo passwd -x 5 $user
        fi
    done
else

# Do nothing and echo if user not admin
echo "Only Admin can onBoard User"
fi
