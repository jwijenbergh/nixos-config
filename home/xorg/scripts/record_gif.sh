#!/usr/bin/env bash
TMPFILE="$(mktemp -t gif-XXXXXXX)"
OUTPUT="$HOME/Pictures/Screencasts/$(date +%F-%H-%M-%S)".gif

read -r X Y W H G ID < <(slop -f "%x %y %w %h %g %i")
ffmpeg -f x11grab -s "$W"x"$H" -i :0.0+$X,$Y "$TMPFILE%04d.png"

gifski -r 24 -W "$W" -H "$H" -o "$OUTPUT" "$TMPFILE"*.png

sxiv -a "$OUTPUT"

trap "rm -f '$TMPFILE*.png'" 0
