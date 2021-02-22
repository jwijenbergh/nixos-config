#!/bin/sh
# Usage: ./xresources-to-nix.sh input output.nix

input="$1"
output="$2"

xresources="$(cat  "$input")"
replaced="$(echo "$xresources" | sed -e '/^!/d' -e '/^$/d' -e 's/\ //g' -e 's/\*/  /g' -e 's/[\.#]//g' -e 's/:/ = "/g' -e 's/$/";/g')"
printf "{\n%s\n}" "$replaced" > "$output"
