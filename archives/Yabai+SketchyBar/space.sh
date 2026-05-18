#!/bin/bash

# Space indicator - shows only active spaces on all displays

ACCENT=0xffe0c15a
DIM=0xff565f89
ISLAND_BORDER=0xff263356

sid="${NAME##*.}"

SpaceInfo=$(yabai -m query --spaces | jq -r ".[] | select(.index == $sid)" 2>/dev/null)

if [ -z "$SpaceInfo" ]; then
  # Space doesn't exist, hide it
  sketchybar --set $NAME background.drawing=off label.drawing=off
else
  # Space exists, check if it has focus
  HasFocus=$(echo "$SpaceInfo" | jq -r ".[\"has-focus\"]" 2>/dev/null)
  
  if [ "$HasFocus" = "true" ]; then
    sketchybar --set $NAME \
      label.color=$ACCENT \
      label.font="IosevkaTerm NF:Bold:12.0" \
      background.border_color=$ACCENT \
      background.drawing=on \
      label.drawing=on
  else
    sketchybar --set $NAME \
      label.color=$DIM \
      label.font="IosevkaTerm NF:Regular:12.0" \
      background.border_color=$ISLAND_BORDER \
      background.drawing=on \
      label.drawing=on
  fi
fi