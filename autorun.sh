#!/bin/bash

if ! command -v inotifywait &>/dev/null
then
	echo "inotify-tools package is required!"
	exit 1
fi

# requires inotify-tools
while true
do
	inotifywait -e modify $(find . -name "*.tex" -or -name "*.sty" -or -name "*.bib" -or -path "figs/*.jpg" -or -path "figs/*.png" -or -path "figs/*.svg" -or -path "figs/*.pdf")
	make
done
