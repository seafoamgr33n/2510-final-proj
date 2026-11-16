#!/usr/bin/env bash
# TAKE INPUT
FIRST=$1
LAST=$2

# PARSE INPUT
USER="$FIRST.$LAST"
PASS="${FIRST}${LAST}HALBERD"

echo -e "Adding $FIRST $LAST with credentials:\n  Username = $USER\n  Password = $PASS\nAs a registered user."

# CONFIRM
while true; do
    read -r -p "OK? [Y/n]" yn       # Ask for comfirmation
    echo ""                         # Space
    if [[ $yn =~ ^[Yy]$ ]]; then    # Confirmation evail
        echo "OK"
        break
    elif [[ $yn =~ [Nn]$ ]]; then
        echo "Cancelled"
        break
    else
        echo "Invalid.\n"
    fi
done

exit 55                             # Felt smart (11:53PM) might evaluate later
