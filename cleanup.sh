#!/usr/bin/env bash

ls /usr/local/bastille/jails 2>/dev/null || { echo "No remaining containers."; exit; }

for container in $(ls /usr/local/bastille/jails 2>/dev/null | cut -d '/' -f 6); do
	bastille stop $container
	bastille destroy $container
done

echo
echo
echo

ls /usr/local/bastille/jails 2>/dev/null || { echo "All containers removed."; exit; }

echo "Containers that could not be stopped+destroyed properly:"

for container in $(ls /usr/local/bastille/jails 2>/dev/null | cut -d '/' -f 6); do
	echo "- $container"
done

echo
echo
ANSWER="x"
while [ "$ANSWER" != "y" ] && [ "$ANSWER" != "Y" ] && [ "$ANSWER" != "n" ] && [ "$ANSWER" != "N" ]; do
	read -p "Forcefully clean up? [Y/n] " ANSWER
done

if [ "$ANSWER" == "n" ] || [ "$ANSWER" == "N" ]; then
	echo "Aborting."
	exit
fi

chflags noschg /usr/local/bastille/jails/*/root/var/empty
rm -rf /usr/local/bastille/jails/*
