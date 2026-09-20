#!/usr/bin/env bash

set -e

LINK_PATH="$HOME/wine-stable"
DIR_WINE9="$HOME/wine-stable9"
DIR_WINE11="$HOME/wine-stable11"

# Verify that both target version directories exist
if [ ! -d "$DIR_WINE9" ] || [ ! -d "$DIR_WINE11" ]; then
    echo "[✗] Error: Missing target directories."
    echo "    Ensure both $DIR_WINE9 and $DIR_WINE11 exist."
    exit 1
fi

# Determine current target if symlink exists
CURRENT_TARGET=""
if [ -L "$LINK_PATH" ]; then
    CURRENT_TARGET=$(readlink -f "$LINK_PATH")
elif [ -d "$LINK_PATH" ]; then
    echo "[!] Warning: $LINK_PATH is a physical directory, not a symlink."
    echo "    Please rename/backup your current $LINK_PATH to wine-stable9 or wine-stable11 first."
    exit 1
fi

# Toggle logic
if [ "$CURRENT_TARGET" = "$DIR_WINE9" ]; then
    echo "[*] Current: Wine 9 -> Switching to Wine 11..."
    ln -sfn "$DIR_WINE11" "$LINK_PATH"
    echo "[✓] Active symlink: ~/wine-stable -> ~/wine-stable11"
else
    echo "[*] Current: Wine 11 (or unlinked) -> Switching to Wine 9..."
    ln -sfn "$DIR_WINE9" "$LINK_PATH"
    echo "[✓] Active symlink: ~/wine-stable -> ~/wine-stable9"
fi

wine --version
