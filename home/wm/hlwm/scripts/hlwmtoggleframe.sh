#!/usr/bin/env bash
VALUE="$(herbstclient get frame_transparent_width)"

if [ "$VALUE" = "0" ]
then
    herbstclient set frame_transparent_width 2
else
    herbstclient set frame_transparent_width 0
fi
