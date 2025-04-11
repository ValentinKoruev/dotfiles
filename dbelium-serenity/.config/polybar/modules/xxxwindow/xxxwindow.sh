#!/bin/bash

FOCUSED_WIN_ID=$(xdotool getwindowfocus 2>/dev/null)

# fallback values
WM_DESKTOP="Empty"
WM_CLASS="Empty"
WM_NAME="Empty"

if [[ -n "$FOCUSED_WIN_ID" && "$FOCUSED_WIN_ID" =~ ^[0-9]+$ ]]; then
    # try to get the desktop number
    WM_DESKTOP_OUTPUT=$(xprop -id "$FOCUSED_WIN_ID" _NET_WM_DESKTOP 2>/dev/null)
    if [[ "$WM_DESKTOP_OUTPUT" =~ ([0-9]+)$ ]]; then
        WM_DESKTOP="${BASH_REMATCH[1]}"
    fi

    # try to get WM_CLASS safely
    WM_CLASS_OUTPUT=$(xprop -id "$FOCUSED_WIN_ID" WM_CLASS 2>/dev/null)
    if [[ "$WM_CLASS_OUTPUT" =~ \"([^\"]+)\"[[:space:]]*,[[:space:]]*\"([^\"]+)\" ]]; then
        WM_CLASS="${BASH_REMATCH[2]}"
    fi

    # try to get WM_NAME safely
    WM_NAME_OUTPUT=$(xprop -id "$FOCUSED_WIN_ID" WM_NAME 2>/dev/null)
    if [[ "$WM_NAME_OUTPUT" =~ \"(.*)\" ]]; then
        WM_NAME="${BASH_REMATCH[1]}"
    fi

    # format specific classes if needed
    case "$WM_CLASS" in
        "Code")
            echo "Visual Studio Code"
            ;;
        "Brave-browser")
            echo "Brave"
            ;;
        *)
            # capitalize first letter and echo
            echo "${WM_CLASS^}"
            ;;
    esac
fi
