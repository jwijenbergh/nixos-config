#!/usr/bin/env bash

# Format the Panel
fifo="/tmp/panel_fifo"
[ -e "$fifo" ] && rm "$fifo"
mkfifo "$fifo"

textColor="#d5c4a1"
light4Color="#a89984"
light0Color="#ffffc8"
dark2Color="#504945"
redColor="#fb4934"
greenColor="#b8bb26"

_date() {
	printf "%s\n" "date%{F${light0Color}}$(date +%H:%M)"
}

_workspaces() {
	workspaces="$(herbstclient tag_status)"
	string=""
	for workspace in $workspaces
	do
	    if [ "${workspace:0:1}" = '#' ]; then # Active tag
		string="$string %{F${greenColor}} ${workspace:1}";
	    fi
	    if [ "${workspace:0:1}" = '-' ]; then # Active on other monitor
		string="$string %{F${light0Color}} ${workspace:1}";
	    fi
	    if [ "${workspace:0:1}" = ':' ]; then # Open tag
		string="$string %{F${light4Color}} ${workspace:1}";
	    fi
	    if [ "${workspace:0:1}" = '.' ]; then # Disabled tag
		string="$string %{F${dark2Color}} ${workspace:1}";
	    fi
	done

	printf "%s\n" "tags${string}"
}

while :; do _workspaces; sleep .1s; done > "$fifo" &
while :; do _date; sleep 60s; done > "$fifo" &

while read -r line ; do

    case $line in
	tags*)
	    tags="${line:4}"
	    ;;
	date*)
	    date="${line:4}"
	    ;;
    esac
    echo  "%{S0} %{c} ${tags} %{r} ${date} %{S1} %{c} ${tags} %{r} ${date} " ;

done < "$fifo" | lemonbar 1920x80 -f "Iosevka:pixelsize=15" -B "#222222" -F "#000000" | bash; exit
