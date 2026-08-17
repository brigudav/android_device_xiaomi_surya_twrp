#!/sbin/sh
# Monitor volume-up (KEY_VOLUMEUP) long-press and run `killall recovery`
# Places: /sbin/vol_up_longpress.sh

PRESS_TS=""

# make sure getevent exists
command -v getevent >/dev/null 2>&1 || exit 0

# Prefer gpio-keys device if present
EVENT_DEV="/dev/input/event3"
if [ ! -e "$EVENT_DEV" ]; then
  # try to auto-detect a device that advertises key code 0073
  EVENT_DEV=""
  for d in /dev/input/event*; do
    [ -e "$d" ] || continue
    if getevent -p "$d" 2>/dev/null | grep -q "0073"; then
      EVENT_DEV="$d"
      break
    fi
  done
fi

if [ -n "$EVENT_DEV" ]; then
  GETEVENT_CMD="getevent -lt $EVENT_DEV"
else
  GETEVENT_CMD="getevent -lt"
fi

# run the watcher
$GETEVENT_CMD | while read -r ts dev type code value; do
  # strip brackets from ts
  ts=${ts#"["}
  ts=${ts%"]"}
  # detect EV_KEY (0001) + code 0073 (hex for 115 -> KEY_VOLUMEUP)
  if [ "$type" = "0001" ] && [ "$code" = "0073" ]; then
    if [ "$value" = "00000001" ]; then
      PRESS_TS="$ts"
    elif [ "$value" = "00000000" ] && [ -n "$PRESS_TS" ]; then
      # compare float times and trigger if >= 2.0 seconds
      awk -v a="$PRESS_TS" -v b="$ts" 'BEGIN{ if ((b - a) >= 2.0) exit 0; exit 1 }'
      if [ $? -eq 0 ]; then
        # try killall, fallback to pidof+kill or pkill
        if command -v killall >/dev/null 2>&1; then
          /sbin/killall recovery >/dev/null 2>&1 &
        elif command -v pidof >/dev/null 2>&1; then
          for p in $(pidof recovery 2>/dev/null || true); do
            [ -n "$p" ] && kill -9 "$p" >/dev/null 2>&1 || true
          done &
        else
          pkill -f recovery >/dev/null 2>&1 &
        fi
      fi
      PRESS_TS=""
    fi
  fi
done
