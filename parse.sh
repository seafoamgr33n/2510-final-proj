#!/bin/bash

#for all of the lines in the file that is input/piped in
while read -r LINE
do
	#extract first name from a lineinto a var
	FIRST=$( echo $LINE | awk '{ print $1 }' )

	#extract lastname from a line into a var
	LAST=$( echo $LINE | awk '{ print $2 }' )

	sudo bash ./makeuser.sh "$FIRST" "$LAST" # call makeuser

done < "$1"
