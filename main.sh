#!/usr/bin/env bash

# -------------------- STARTUP CHECKS --------------------
TARGET_OS="ubuntu"
TARGET_OS_VERSION="26.04"

TARGET_BASH_VERSION="5.3.9"

# ---------- CHECK OS ----------
# os-release details
#PRETTY_NAME        = Printed
#NAME               = Official title
#VERSION_ID         = Numerical version value
#VERSION            = May contain alpha. Ex (trixie)
#VERSION_CODENAME   = Alpha-based version name
#ID                 = Distro name. Ex (debian)
. /etc/os-release   # Checking os-release file for details on OS

# Check that the os ID is ubutnu
if [ "$TARGET_OS" != $ID ]; then
    message="Ubuntu not detected. In order to achieve advertised results, please install at least ($TARGET_OS $TARGET_OS_VERSION). Proceed with caution."
# Pass target and actual to sort, return smallest version
# Check if lower version is at least the same as our target
elif [ "$(printf '%s\n' "$TARGET_OS_VERSION" "$VERSION_ID" | sort -V | head -n1)" != "$TARGET_OS_VERSION" ]; then
    message="Ubuntu version is too old. Quality is only assured on version $TARGET_OS_VERSION or later. Proceed with caution."
# Correct versions
else
    message="OK: Ubuntu $VERSION_ID meets the requirement (>= $TARGET_OS)"
fi
echo $message


# ---------- Check Bash Version ----------
EXPECTED_VERSION=$(echo "${BASH_VERSINFO[0]}.${BASH_VERSINFO[1]}.${BASH_VERSINFO[2]}")
if [ "$(printf "$EXPECTED_VERSION" "$TARGET_BASH_VERSION" | sort -V | head -n1)" != "$TARGET_BASH_VERSION" ]; then
    echo "Bash version is incorrect or could not be found!"
else
    echo "OK: Bash $BASH_VERSION meets requirement (>= $TARGET_BASH_VERSION)"
fi

# ---------- Check Licensing ----------
sudo bash ./licensing.sh


# -------------------- MAIN MENU --------------------
# Menu Array
MAIN_MENU=("1. Migrate Users"	# Scrape and instantiate all users from web page
           "2. Add User"	# Manually name and add a user 
           "3. Exit")		# Leave

# Input Loop
while (true); do
	echo "Main Menu"
	echo "${MAIN_MENU[@]}"
	read -p "Selection: " selection

	if [[ $selection =~ ^[1]*$ ]]; then
		clear
		echo "Migrating"
		bash ./find_faculty.sh
		sudo bash ./mkuser.sh "./parsed_faculty_staff.txt"
		rm ./parsed_faculty_staff.txt
	elif [[ $selection =~ ^[2]*$ ]]; then
		clear
		echo "Adding User"
	elif [[ $selection =~ ^[3]*$ ]]; then
		echo "Exiting"
	exit 1
		else
		echo "Please choose a list item [1 - ${#MAIN_MENU[@]}]"
	fi
done

echo $selection

exit 0
