#!/usr/bin/env bash
textColor="#d5c4a1"
light4Color="#a89984"
light0Color="#ffffc8"
dark2Color="#504945"
redColor="#fb4934"
greenColor="#b8bb26"

_tags() {
    output=""
    tags="$(herbstclient tag_status)"
    for tag in $tags
    do
	if [ "${tag:0:1}" = '#' ]; then # Active tag
	    output="$output %{F${greenColor}} ${tag:1}";
	fi
	if [ "${tag:0:1}" = '-' ]; then # Active on other monitor
	    output="$output %{F${light0Color}} ${tag:1}";
	fi
	if [ "${tag:0:1}" = ':' ]; then # Open tag
	    output="$output %{F${light4Color}} ${tag:1}";
	fi
	if [ "${tag:0:1}" = '.' ]; then # Disabled tag
	    output="$output %{F${dark2Color}} ${tag:1}";
	fi
    done
    printf "%s\n" "${output}"
}

_tags

IFS="$(printf '\t')" herbstclient --idle | while read -r hook args; do
    case "$hook" in
	tag*)
	    _tags
	    ;;
    esac
done
