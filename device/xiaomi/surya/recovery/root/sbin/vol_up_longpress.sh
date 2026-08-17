#!/sbin/sh
# Monitor volume-up (KEY_VOLUMEUP) long-press and run `killall recovery`
# Places: /sbin/vol_up_longpress.sh

PRESS_TS=""

# make sure getevent exists
command -v getevent >/dev/null 2>&1 || exit 0

# getevent -lt outputs lines like: "[  123.456789] /dev/input/event2: 0001 0073 00000001"
getevent -lt | while read -r ts dev type code value; do
  # strip brackets from ts
  ts=${ts#"["}
  ts=${ts%"]"}
  # detect EV_KEY (0001) + code 0073 (hex for 115 -> KEY_VOLUMEUP)
  if [ "$type" = "0001" ] && [ "$code" = "0073" ]; then
    if [ "$value" = "00000001" ]; then
      PRESS_TS="$ts"
    elif [ "$value" = "00000000" ] && [ -n "$PRESS_TS" ]; then
      # compare float times and trigger if >= 2.0 seconds
      awk -v a="$PRESS_TS" -v b="$ts" 'BEGIN{ if ((b - a) >= 2.0) { system("/sbin/killall recovery >/dev/null 2>&1 &") } }'
      PRESS_TS=""
    fi
  fi
done
