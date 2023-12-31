#!/bin/bash

# The name of polybar bar which houses the main spotify module and the control modules.
PARENT_BAR="main"
PARENT_BAR_PID=$(pgrep -a "polybar" | grep "$PARENT_BAR" | cut -d" " -f1)

# Set the source audio player here.
# Players supporting the MPRIS spec are supported.
# Examples: spotify, vlc, chrome, mpv and others.
# Use `playerctld` to always detect the latest player.
# See more here: https://github.com/altdesktop/playerctl/#selecting-players-to-control
#
PLAYER="playerctld"
# PLAYER="spotify"

# Format of the information displayed
# Eg. {{ artist }} - {{ album }} - {{ title }}
# See more attributes here: https://github.com/altdesktop/playerctl/#printing-properties-and-metadata
FORMAT="{{ title }} - {{ artist }}"

PLAYERCTL_STATUS=$(playerctl --player=$PLAYER status 2>/dev/null)
EXIT_CODE=$?

update_hooks() {
    while IFS= read -r id
    do
        polybar-msg -p "$id" action spotify-play-pause hook $2 1>/dev/null 2>&1
        polybar-msg -p "$id" action spotify-next hook $2 1>/dev/null 2>&1
        polybar-msg -p "$id" action spotify-prev hook $2 1>/dev/null 2>&1
    done < <(echo "$1")
}

if [ $EXIT_CODE -eq 0 ]; then
    STATUS=$PLAYERCTL_STATUS
else
    STATUS="No player is running"
fi

if [ "$1" == "--status" ]; then
    echo $STATUS
else
    if [ "$STATUS" = "Stopped" ]; then
        update_hooks "$PARENT_BAR_PID" 0
        # echo "No music is playing"
        echo
    elif [ "$STATUS" = "Paused"  ]; then
        update_hooks "$PARENT_BAR_PID" 2
        # playerctl --player=$PLAYER metadata --format "$FORMAT"
        echo
    elif [ "$STATUS" = "No player is running"  ]; then
        update_hooks "$PARENT_BAR_PID" 0
        # echo "$STATUS"
        echo
    else
        update_hooks "$PARENT_BAR_PID" 1
        # playerctl --player=$PLAYER metadata --format "$FORMAT"
        echo
    fi
fi
