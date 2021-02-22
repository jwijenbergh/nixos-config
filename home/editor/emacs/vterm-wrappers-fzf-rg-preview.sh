#!/usr/bin/env bash
# Script to preview a file with a certain line in the center and a max height
# Uses bat if available for highlighting
# $1 = Filename
# $2 = LINE:COLUMN:MATCH

function preview_tail_head {
	tail -n "+$2" "$1" | head -n "$(($3-$2+1))"
}

function preview_bat {
	bat --color=always --style=numbers --highlight-line "$4" --line-range "$2":"$3" "$1"
}

FILENAME="$1"
LINE="$(echo "$2" | cut -d ':' -f1)"
preview_cmd="preview_tail_head"

if type -p bat &>/dev/null; then
	preview_cmd="preview_bat"
fi

START=$((LINE-(LINES/2)))
END=$((LINE+(LINES)/2))

if [ "$START" -le 0 ]; then
	END=$((END-START+1))
	START=1
fi

$preview_cmd "$FILENAME" "$START" "$END" "$LINE"
