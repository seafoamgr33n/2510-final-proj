HAlberd Technologies Faculty Account Tool: Usage Manual
Team Awesome Sauce: Reed Smith, Masha Kochan, Ethan Weller, Devin Bain CSC 2510 DevOps Final Project
This tool creates Ubuntu accounts for TNTech Computer Science faculty. It reads names from the department website, lets you add one user by hand, and asks for a license key before it runs.
Before You Start
• Ubuntu 26.04
• Bash 5.3.9
• curl 8.18.0 (the version included with Ubuntu 26.04)
• git, to download the code
• Internet access and sudo rights
• The 16-digit license key from the Scrum master's email
Get the Code
Install git if it is not already installed:
sudo apt install git
Clone the repository and move into its folder:
git clone https://github.com/seafoamgr33n/2510-final-proj.git
cd 2510-final-proj
Check your versions with these commands:
bash --version
curl --version
The first line of each result shows the version number.
Setup
Open a terminal in the project folder and run:
chmod +x *.sh
Run the Program
sudo ./main.sh
On the first run, the program asks for the license key. Type the 16 digits and press Enter. You only enter the key once.
Menu
Choose an option from the menu.
• 1. Migrate users: download the faculty page, read the names, and create an account for each person.
• 2. Add user: type a first name and a last name, and the program creates one account.
• 3. Exit
Usernames and Passwords
Accounts use the same format every time. For example, Jane Doe gets:
• Username: jane.doe
• Password: janedoeHALBERD
Check That It Worked
• Go to switch user in ubuntu or log out
If the account exists, the system shows its user ID.
Common Problems
• Permission denied: run chmod +x *.sh.
• Run as root: start the program with sudo.
• Invalid license key: enter the key from the email again.
• No names found: check the internet connection.# User Migration Manual
## Optimal Environment 
Before running, the script will check that the requirements are met. The script targets Ubuntu 20.04 and Bash version 5.3.9 for optimal performance.
## Main Menu

### 1. Migrate Users
Using curl, scrape users from the faculty page and automatically add users with the username first.last and password firstlastHALBERD.
## 2. Manual Add 
Manually input a username and password, to create a user with the same user/pass conventions as above.
## 3. Quit
The program will not run without the proper licensing file in the active directory or provided 16-digit key. 

