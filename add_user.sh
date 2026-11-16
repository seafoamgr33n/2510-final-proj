#!/usr/bin/env bash
# TAKE INPUT
FIRST=$1
LAST=$2

# PARSE INPUT
USER="$FIRST.$LAST"
PASS="${FIRST}${LAST}HALBERD"

echo -e "Adding $FIRST $LAST with credentials:  Username = $USER as a registered user."

# CONFIRM
while true; do
    read -r -p "OK? [Y/n]" yn       # Ask for comfirmation
    echo ""                         # Space
    if [[ $yn =~ ^[Yy]$ ]]; then    # Confirmation evail
        echo "OK"
        #create a USER
        USER="$FIRST.$LAST"

        #create a PASS
        PASS="${FIRST}${LAST}HALBERD"

        #create a user account
        #ideally add -m for a home directory for the user and defaults
        #but im not doing that
        useradd $USER

        #set the password bc useradd needs an encrypted (not plaintext) pass
        echo "$USER:$PASS" | chpasswd
        break
    elif [[ $yn =~ [Nn]$ ]]; then
        echo "Cancelled"
        break
    else
        echo "Invalid.\n"
    fi
done

exit 55                             # Felt smart (11:53PM) might evaluate later
