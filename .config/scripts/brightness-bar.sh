#!/bin/bash

BRIGHTNESS=$(cat /sys/class/backlight/*/brightness 2>/dev/null | head -1)
MAX=$(cat /sys/class/backlight/*/max_brightness 2>/dev/null | head -1)

# Fallback
if [ -z "$BRIGHTNESS" ] || [ -z "$MAX" ] || [ "$MAX" -eq 0 ]; then
    echo "? [??????????] ?%"
    exit 1
fi

# Alterna entre f185 e f522 a cada 4 runs (~4s)
FRAME_FILE="/tmp/brightness_frame"
SLOW_CTR_FILE="/tmp/brightness_slow_ctr"

FRAME=$(cat "$FRAME_FILE" 2>/dev/null || echo "0")
SLOW_CTR=$(cat "$SLOW_CTR_FILE" 2>/dev/null || echo "0")

SLOW_CTR=$(( (SLOW_CTR + 1) % 4 ))
echo "$SLOW_CTR" > "$SLOW_CTR_FILE"

if [ "$SLOW_CTR" -eq 0 ]; then
    FRAME=$(( (FRAME + 1) % 2 ))
    echo "$FRAME" > "$FRAME_FILE"
fi

if [ "$FRAME" -eq 0 ]; then
    ICON=$(printf '\uf185')
else
    ICON=$(printf '\uf522')
fi

PERCENT=$(( BRIGHTNESS * 100 / MAX ))
TOTAL=10
FILLED=$(( PERCENT * TOTAL / 100 ))
EMPTY=$(( TOTAL - FILLED ))

BAR="["
for i in $(seq 1 $FILLED); do BAR="${BAR}█"; done
for i in $(seq 1 $EMPTY); do BAR="${BAR}░"; done
BAR="${BAR}]"

echo "$ICON $BAR $PERCENT%"
