#!/bin/bash

# よし君の Wine Prefix パス
TARGET_PREFIX="/home/jialong/.wine64"

# 現在の状態を確認
CURRENT_SETTING=$(WINEPREFIX=$TARGET_PREFIX wine reg query "HKEY_CURRENT_USER\Software\Wine\DllOverrides" /v "d2d1" 2>/dev/null)

if [[ $CURRENT_SETTING == *"disabled"* ]]; then
    # 現在 Disabled なので、Native Access 用に「有効 (builtin)」にする
    WINEPREFIX=$TARGET_PREFIX wine reg add "HKEY_CURRENT_USER\Software\Wine\DllOverrides" /v "d2d1" /d "builtin" /f
    echo "✅ d2d1 ENABLED (Native Access Mode)"
else
    # 現在 Enabled (または設定なし) なので、VST 用に「無効 (disabled)」にする
    WINEPREFIX=$TARGET_PREFIX wine reg add "HKEY_CURRENT_USER\Software\Wine\DllOverrides" /v "d2d1" /d "disabled" /f
    echo "🚀 d2d1 DISABLED (VST Mode)"
fi

# Yabridge を同期して反映させる
yabridgectl sync
