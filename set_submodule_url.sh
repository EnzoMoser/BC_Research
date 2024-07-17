#!/usr/bin/env bash
# If you type "ssh" as an argument, it will set the submodule repos to the ssh variant.
# Never manually add ssh urls. Only use "git submodule add" to add https, and then swap to ssh variant with this command.
# This allows the git repo to use only https, making cloning easier for the public.

set -eo pipefail # Exit if any command fails. Print command.

if [ "$1" == "ssh" ]; then
  cp .gitmodules .temp_gitmodules
  perl -p -e 's|https://(.*?)/|git@\1:|g' .temp_gitmodules > .gitmodules
  git submodule sync
  cp .temp_gitmodules .gitmodules
  rm .temp_gitmodules
  echo -e "\n--> Submodules set to SSH. Run this command with no argument to swap to https.\n"
else
  git submodule sync
  echo -e "\n--> Submodules set to HTTPS. Use the argument 'ssh' to swap to ssh.\n"
fi

# Change from ssh to https. (Not Needed)
# perl -p -e 's|git@(.*?):|https://\1/|g' input.txt > output.txt
