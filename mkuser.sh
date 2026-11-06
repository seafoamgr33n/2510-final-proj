
#!/bin/bash

#for all of the lines in the file that is input/piped in
while read -r LINE
do
	#extract first name from a lineinto a var
	FIRST=$( echo $LINE | awk '{ print $1 }' )

	#extract lastname from a line into a var
	LAST=$( echo $LINE | awk '{ print $2 }' )

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

done < "$1"
