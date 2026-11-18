
#!/bin/bash
# pull in user and password in a loop

FIRST="$1" # first input
LAST="$2"

#create a USER
USER="$FIRST.$LAST"

#create a PASS
# PASS="${FIRST}${LAST}HALBERD"

# randomly generate a list of 12 numbers.
LIST=($(shuf -i 0-9 -n 12))
PASS=""

for E in "${LIST[@]}"; do
	PASS+="$E" # append to password
done

echo "Creating user with user $USER and randomly generated password output to userpassoutput.txt "
echo "USERNAME: $USER PASSWORD: $PASS" >> userpassoutput.txt

#create a user account
#ideally add -m for a home directory for the user and defaults 
#but im not doing that
useradd "$USER"

#set the password bc useradd needs an encrypted (not plaintext) pass
echo "$USER:$PASS" | chpasswd
