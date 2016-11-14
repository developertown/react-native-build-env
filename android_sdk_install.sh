#!/usr/bin/env bash

echo "Searching for $1..."
INSTALL_INDEX=`android list sdk -a | grep "$1" | awk -F \- '{ print $1 }' | sed 's/ //g'`
echo "Installing $1..."
echo y | android update sdk --no-ui -a --filter $INSTALL_INDEX > /dev/null