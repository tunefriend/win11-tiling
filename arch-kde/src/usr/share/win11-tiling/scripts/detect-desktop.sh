#!/bin/sh
# Detect the active desktop environment.

detect_desktop() {
    if [ -n "$XDG_CURRENT_DESKTOP" ]; then
        case "$XDG_CURRENT_DESKTOP" in
            *GNOME*|*gnome*)
                echo "gnome"
                return 0
                ;;
            *KDE*|*kde*)
                echo "kde"
                return 0
                ;;
            *XFCE*|*xfce*)
                echo "xfce"
                return 0
                ;;
            *MATE*|*mate*)
                echo "mate"
                return 0
                ;;
            *Cinnamon*|*cinnamon*)
                echo "cinnamon"
                return 0
                ;;
        esac
    fi

    if [ -n "$DESKTOP_SESSION" ]; then
        case "$DESKTOP_SESSION" in
            gnome*|ubuntu)
                echo "gnome"
                return 0
                ;;
            plasma*|kde*)
                echo "kde"
                return 0
                ;;
            xfce*)
                echo "xfce"
                return 0
                ;;
        esac
    fi

    if pgrep -x gnome-shell >/dev/null 2>&1; then
        echo "gnome"
        return 0
    fi

    if pgrep -x kwin_wayland >/dev/null 2>&1 || pgrep -x kwin_x11 >/dev/null 2>&1; then
        echo "kde"
        return 0
    fi

    if [ "$XDG_SESSION_TYPE" = "x11" ]; then
        echo "x11"
        return 0
    fi

    echo "unknown"
}

detect_desktop