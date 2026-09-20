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

# WINEPREFIX=/data/.wine64 wine reg add "HKEY_CURRENT_USER\Software\Wine\Direct2D" /v "max_version_factory" /t REG_DWORD /d 1 /f
# WINEPREFIX=/data/.wine64 wine reg add "HKEY_CURRENT_USER\Software\Wine\Direct3D" /v "DirectComposition" /t REG_DWORD /d 0 /f
# WINEPREFIX=/data/.wine64 wine reg add "HKEY_CURRENT_USER\Software\Wine\DllOverrides" /v "dcomp" /d "" /f

# WINEPREFIX=/data/.wine64 wine reg delete "HKEY_CURRENT_USER\Software\Wine\Direct3D" /v "DirectComposition" /f 2>/dev/null || true
# WINEPREFIX=/data/.wine64 wine reg delete "HKEY_CURRENT_USER\Software\Wine\Direct2D" /v "max_version_factory" /f 2>/dev/null || true
# WINEPREFIX=/data/.wine64 wine reg delete "HKEY_CURRENT_USER\Software\Wine\DllOverrides" /v "dcomp" /f 2>/dev/null || true
# WINEPREFIX=/data/.wine64 wine reg delete "HKEY_CURRENT_USER\Software\Wine\DllOverrides" /v "d3d11" /f 2>/dev/null || true
# WINEPREFIX=/data/.wine64 wine reg delete "HKEY_CURRENT_USER\Software\Wine\DllOverrides" /v "dxgi" /f 2>/dev/null || true

# 3. 確保完全重設並更新 WinePrefix 設定
WINEPREFIX=/data/.wine64 wineboot -u

# Yabridge を同期して反映させる
yabridgectl sync
