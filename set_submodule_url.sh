#!/usr/bin/env sh
# If you type "ssh" as an argument, it will set the submodule repos to the ssh variant.
# Never manually add ssh urls. Only use "git submodule add" to add https, and then swap to ssh with this command.

if [ "$1" == "ssh" ]; then
  cp .gitmodules .temp_gitmodules
  perl -p -e 's|https://(.*?)/|git@\1:|g' .temp_gitmodules > .gitmodules
  git submodule sync
  cp .temp_gitmodules .gitmodules
  rm .temp_gitmodules
else
  git submodule sync
fi

# Change from ssh to https. (Not Needed)
# perl -p -e 's|git@(.*?):|https://\1/|g' input.txt > output.txt
