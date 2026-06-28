#!/bin/bash
# X11 window tiling via wmctrl (Windows 11-style snap positions).

set -euo pipefail

POSITION="${1:-}"

if ! command -v wmctrl >/dev/null 2>&1; then
    echo "wmctrl is required for X11 tiling. Install with: apt install wmctrl" >&2
    exit 1
fi

if ! command -v xdotool >/dev/null 2>&1; then
    echo "xdotool is required for X11 tiling. Install with: apt install xdotool" >&2
    exit 1
fi

eval "$(xdotool getdisplaygeometry --shell)"
# xdotool reports WIDTH and HEIGHT

tile_left() {
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz 2>/dev/null || true
    wmctrl -r :ACTIVE: -e "0,0,0,$((WIDTH / 2)),$HEIGHT"
}

tile_right() {
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz 2>/dev/null || true
    wmctrl -r :ACTIVE: -e "0,$((WIDTH / 2)),0,$((WIDTH / 2)),$HEIGHT"
}

tile_top() {
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz 2>/dev/null || true
    wmctrl -r :ACTIVE: -e "0,0,0,$WIDTH,$((HEIGHT / 2))"
}

tile_bottom() {
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz 2>/dev/null || true
    wmctrl -r :ACTIVE: -e "0,0,$((HEIGHT / 2)),$WIDTH,$((HEIGHT / 2))"
}

tile_top_left() {
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz 2>/dev/null || true
    wmctrl -r :ACTIVE: -e "0,0,0,$((WIDTH / 2)),$((HEIGHT / 2))"
}

tile_top_right() {
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz 2>/dev/null || true
    wmctrl -r :ACTIVE: -e "0,$((WIDTH / 2)),0,$((WIDTH / 2)),$((HEIGHT / 2))"
}

tile_bottom_left() {
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz 2>/dev/null || true
    wmctrl -r :ACTIVE: -e "0,0,$((HEIGHT / 2)),$((WIDTH / 2)),$((HEIGHT / 2))"
}

tile_bottom_right() {
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz 2>/dev/null || true
    wmctrl -r :ACTIVE: -e "0,$((WIDTH / 2)),$((HEIGHT / 2)),$((WIDTH / 2)),$((HEIGHT / 2))"
}

tile_maximize() {
    wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
}

tile_restore() {
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
    wmctrl -r :ACTIVE: -e "0,100,100,$((WIDTH - 200)),$((HEIGHT - 200))"
}

case "$POSITION" in
    left)          tile_left ;;
    right)         tile_right ;;
    top)           tile_top ;;
    bottom)        tile_bottom ;;
    top-left)      tile_top_left ;;
    top-right)     tile_top_right ;;
    bottom-left)   tile_bottom_left ;;
    bottom-right)  tile_bottom_right ;;
    maximize|up)   tile_maximize ;;
    restore|down)  tile_restore ;;
    center)
        wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz 2>/dev/null || true
        wmctrl -r :ACTIVE: -e "0,$((WIDTH / 4)),$((HEIGHT / 4)),$((WIDTH / 2)),$((HEIGHT / 2))"
        ;;
    *)
        echo "Usage: tile-x11.sh {left|right|top|bottom|top-left|top-right|bottom-left|bottom-right|maximize|restore|center}" >&2
        exit 1
        ;;
esac