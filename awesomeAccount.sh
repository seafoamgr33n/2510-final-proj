#!/usr/bin/env bash

set -e

usage() {
  echo "Usage: awesomeAccount <command> [options]"
  echo
  echo "Commands:"
  echo "  scrape  Scrape the webpage for new users"
  echo "  add     Add a new user"
}

scrape_usage() {
  echo "Usage: awesomeAccount scrape [options]"
  echo
  echo "Options:"
  # echo "  scrape  Create a resource"
}

add_usage() {
  echo "Usage: awesomeAccount add <user> <password>"
  echo
  echo "Options:"
  # echo "  scrape  Create a resource"
}

scrape() {
  # if [[ $# -lt 1 ]]; then
  #   usage
  #   exit 1
  # fi

  # while getopts 'la:' OPTION; do
  #   case "$OPTION" in
  #   l)
  #     echo "linuxconfig"
  #     ;;
  #   a)
  #     avalue="$OPTARG"
  #     echo "The value provided is $OPTARG"
  #     ;;
  #   *)
  #     echo "script usage: TODO" >&2
  #     exit 1
  #     ;;
  #   esac

  #   if [ -v var1 ]; then
  #     echo "The variable is set with an empty string."
  #   fi
  # done
  # shift "$(($OPTIND - 1))"

  response_raw=$(curl -s "https://www.tntech.edu/engineering/programs/csc/faculty-and-staff.php")
  parsed_names=$(
    printf '%s\n' "$response_raw" |
      grep "<h4><strong>" |
      grep -Eo "[A-Za-z]+[[:space:]](&nbsp)?;?[A-Za-z]+" |
      sed "s/&nbsp;//g"
  )

  while read -r LINE; do
    #extract first name from a lineinto a var
    first=$(echo $LINE | awk '{ print $1 }')

    #extract lastname from a line into a var
    last=$(echo $LINE | awk '{ print $2 }')

    #create a USER
    user="$first.$last"

    #create a PASS
    pass="${first}${last}HALBERD"

    create_user "$user" "$pass"

  done <"$parsed_names"
}

add() {
  if [[ $# -lt 2 ]]; then
    add_usage
    exit 1
  fi

  # while getopts 'la:' OPTION; do
  #   case "$OPTION" in
  #   l)
  #     echo "linuxconfig"
  #     ;;
  #   a)
  #     avalue="$OPTARG"
  #     echo "The value provided is $OPTARG"
  #     ;;
  #   *)
  #     echo "script usage: TODO" >&2
  #     exit 1
  #     ;;
  #   esac

  #   if [ -v var1 ]; then
  #     echo "The variable is set with an empty string."
  #   fi
  # done
  # shift "$(($OPTIND - 1))"
}

create_user() {
  user=$1
  pass=$2

  #create a user account
  #ideally add -m for a home directory for the user and defaults
  #but im not doing that
  useradd "$user"

  #set the password bc useradd needs an encrypted (not plaintext) pass
  echo "$user:$pass" | chpasswd
}

get_command() {
  if [[ $# -lt 1 ]]; then
    usage
    exit 1
  fi

  command="$1"
  shift

  case "$command" in
  scrape)
    scrape "$@"
    ;;
  add)
    add "$@"
    ;;
  *)
    printf "Unknown command: %s\n" "$command" >&2
    usage
    exit 1
    ;;
  esac
}

get_command "$@"
