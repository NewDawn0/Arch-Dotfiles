#!/bin/sh
args=$1
noargs () {
	choice=$(du -a | \
	awk '{print $2}' | \
	dmenu -i -p "Search file: ")
	if [ "$choice" ]; then
		printf '%s\n' "$(pwd)/${choice:2}"
	fi
}
hidden () {
	choice=$(find . -path '.*' -ls | \
	awk '{print $11}' | \
	cut -c2- | \
	cut -c2- | \
	dmenu -i -p "Search files: ")
	if [ "$choice" ]; then
		printf '%s\n' "$(pwd)/${choice}"
	fi
}
main () {
	if [ "$args" ]; then
		hidden
	else
		noargs
	fi
}

main
