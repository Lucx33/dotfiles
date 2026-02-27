#!/bin/bash

BAT=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || cat /sys/class/power_supply/BAT1/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null || cat /sys/class/power_supply/BAT1/status)

TOTAL=10
FILLED=$(( BAT * TOTAL / 100 ))
EMPTY=$(( TOTAL - FILLED ))

if [ "$STATUS" = "Charging" ]; then
    ICON="󰂄"
    CLASS=""

    # Animação de enchimento: avança da carga atual até cheio, depois reinicia
    ANIM_FILE="/tmp/battery_anim_frame"
    ANIM_FRAME=$(cat "$ANIM_FILE" 2>/dev/null || echo "0")
    MAX_ANIM=$(( TOTAL - FILLED ))

    if [ "$MAX_ANIM" -gt 0 ]; then
        NEXT_ANIM=$(( (ANIM_FRAME + 1) % (MAX_ANIM + 1) ))
    else
        NEXT_ANIM=0
    fi
    echo "$NEXT_ANIM" > "$ANIM_FILE"

    ANIM_FILLED=$(( FILLED + ANIM_FRAME ))
    ANIM_EMPTY=$(( TOTAL - ANIM_FILLED ))

    BAR="["
    for i in $(seq 1 $ANIM_FILLED); do BAR="${BAR}█"; done
    for i in $(seq 1 $ANIM_EMPTY); do BAR="${BAR}░"; done
    BAR="${BAR}]"
else
    ICON="󰁹"
    CLASS=$( [ "$BAT" -le 20 ] && echo "critical" || echo "" )

    BAR="["
    for i in $(seq 1 $FILLED); do BAR="${BAR}█"; done
    for i in $(seq 1 $EMPTY); do BAR="${BAR}░"; done
    BAR="${BAR}]"
fi

TEXT="$ICON $BAR $BAT%"
echo "{\"text\": \"${TEXT}\", \"class\": \"${CLASS}\", \"percentage\": ${BAT}}"
