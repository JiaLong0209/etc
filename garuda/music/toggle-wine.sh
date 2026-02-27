#!/bin/zsh

# 設定：パスの定義
PORTAL_WINE="$HOME/wine-stable/bin/wine"
PORTAL_WINESERVER="$HOME/wine-stable/bin/wineserver"
SYSTEM_WINE="/usr/bin/wine"
SYSTEM_WINESERVER="/usr/bin/wineserver"

# ZSHRC のパス
ZSHRC="$HOME/.zshrc"

# 現在の設定を確認
if grep -q "$PORTAL_WINE" "$ZSHRC"; then
    # 現在 Wine 9 なので、Wine 11 (System) に切り替え
    sed -i "s|export WINELOADER=\"$PORTAL_WINE\"|export WINELOADER=\"$SYSTEM_WINE\"|" "$ZSHRC"
    sed -i "s|export WINESERVER=\"$PORTAL_WINESERVER\"|export WINESERVER=\"$SYSTEM_WINESERVER\"|" "$ZSHRC"
    echo "🍷 Switched to Wine 11 (System Default)"
else
    # 現在 Wine 11 なので、Wine 9 (Portal) に切り替え
    sed -i "s|export WINELOADER=\"$SYSTEM_WINE\"|export WINELOADER=\"$PORTAL_WINE\"|" "$ZSHRC"
    sed -i "s|export WINESERVER=\"$SYSTEM_WINESERVER\"|export WINESERVER=\"$PORTAL_WINESERVER\"|" "$ZSHRC"
    echo "🚀 Switched to Wine 9 (Portal/Stable)"
fi

# 設定を即座に反映
source "$ZSHRC"
# Yabridge を同期（Wineのバージョンが変わる時は必須！）
yabridgectl sync
