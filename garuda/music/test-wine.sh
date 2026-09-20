#!/bin/zsh

# 定義路徑 (請確認 wine-stable/bin 的絕對路徑正確)
WINE9_BIN="$HOME/wine-stable/bin/wine"
WINE9_SERVER="$HOME/wine-stable/bin/wineserver"
WINE11_BIN="/usr/bin/wine"
WINE11_SERVER="/usr/bin/wineserver"

# 目標連結
TARGET_WINE="/usr/local/bin/wine"
TARGET_WINESERVER="/usr/local/bin/wineserver"

# 檢查目前指向
CURRENT=$(readlink -f $TARGET_WINE 2>/dev/null)

if [[ "$CURRENT" == "$WINE11_BIN" ]]; then
    # 切換到 Wine 9
    sudo ln -sf "$WINE9_BIN" "$TARGET_WINE"
    sudo ln -sf "$WINE9_SERVER" "$TARGET_WINESERVER"
    wine --version
    echo "🚀 全域已切換至：Wine 11.13 (Portal)"
else
    # 切換到 Wine 11
    sudo ln -sf "$WINE11_BIN" "$TARGET_WINE"
    sudo ln -sf "$WINE11_SERVER" "$TARGET_WINESERVER"
    wine --version
    echo "🍷 全域已切換至：Wine 11 (System)"
fi

# 【關鍵修正】：強制讓 /usr/local/bin 成為 PATH 的第一位
if ! grep -q 'export PATH="/usr/local/bin:$PATH"' ~/.zshrc; then
    echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
fi

# 清除 zsh 的路徑快取
hash -r
yabridgectl sync

# #!/bin/zsh
#
# # 1. 定義你電腦裡兩個 Wine 的「真實絕對路徑」
# WINE9_BIN="$HOME/wine-stable/bin/wine"
# WINE11_BIN="/usr/bin/wine"  # Garuda 系統 pacman 裝的原始位置
#
# # 2. 定義 Yabridge 的全域環境變數設定檔路徑
# # Yabridge 官方規定，除了指令前缀，它也會去讀取 ~/.config/environment.d/ 裡面的環境變數
# ENV_DIR="$HOME/.config/environment.d"
# ENV_FILE="$ENV_DIR/10-yabridge-wine.conf"
#
# # 建立設定檔資料夾（如果原本不存在）
# mkdir -p "$ENV_DIR"
#
# # 3. 檢查目前 Yabridge 正在使用哪一個 Wine
# if [ -f "$ENV_FILE" ] && grep -q "$WINE11_BIN" "$ENV_FILE"; then
#     # 【切換到 Wine 9】
#     # 寫入 Yabridge 官方認得的硬編碼路徑覆寫變數
#     echo "YABRIDGE_WINE=\"$WINE9_BIN\"" > "$ENV_FILE"
#     echo "🚀 Yabridge 已成功切換至：Wine 9 (Portal)"
# else
#     # 【切換到 Wine 11】
#     # 讓 Yabridge 回歸系統預設的 Wine 11
#     echo "YABRIDGE_WINE=\"$WINE11_BIN\"" > "$ENV_FILE"
#     echo "🍷 Yabridge 已成功切換至：Wine 11 (System)"
# fi
#
# 4. 強制執行 Yabridge 同步，讓它立刻去讀取剛剛改好的環境變數
# 這樣你不用重新登出 Linux 系統，REAPER 也能立刻吃到最新版本
# yabridgectl sync


# 設定路徑
# PORTAL_BIN="$HOME/wine-stable/bin"
# ZSHRC="$HOME/.zshrc"
#
# # 檢查 .zshrc 中是否已經有這行優先路徑
# if grep -q "export PATH=\"$PORTAL_BIN:\$PATH\"" "$ZSHRC"; then
#     # 目前是 Wine 9 (Portal)，切換到 Wine 11 (System)
#     # 註釋掉該行，讓系統路徑 /usr/bin 回到最前面
#     sed -i "s|^export PATH=\"$PORTAL_BIN:\$PATH\"|# export PATH=\"$PORTAL_BIN:\$PATH\"|" "$ZSHRC"
#     echo "🍷 Switched to Wine 11 (System /usr/bin/wine)"
# else
#     # 目前是 Wine 11 (System)，切換到 Wine 9 (Portal)
#     if grep -q "# export PATH=\"$PORTAL_BIN:\$PATH\"" "$ZSHRC"; then
#         # 如果已經有被註釋的行，取消註釋
#         sed -i "s|^# export PATH=\"$PORTAL_BIN:\$PATH\"|export PATH=\"$PORTAL_BIN:\$PATH\"|" "$ZSHRC"
#     else
#         # 如果完全沒有，直接加在最末尾
#         echo "\nexport PATH=\"$PORTAL_BIN:\$PATH\"" >> "$ZSHRC"
#     fi
#     echo "🚀 Switched to Wine 9 (Portal $PORTAL_BIN)"
# fi
#
# # 提示使用者手動執行 source
# echo "--------------------------------------------------------"
# echo "⚠️  IMPORTANT: Please run 'source ~/.zshrc' in this terminal"
# echo "   to apply the changes, or open a new terminal window."
# echo "--------------------------------------------------------"
#
# # 同步 yabridge (使用當前 PATH 找到的 wine)
# # 注意：這一步會依照你「修改後」的 zshrc 內容進行同步
# yabridgectl sync












# # 設定：パスの定義
# PORTAL_WINE="$HOME/wine-stable/bin/wine"
# PORTAL_WINESERVER="$HOME/wine-stable/bin/wineserver"
# SYSTEM_WINE="/usr/bin/wine"
# SYSTEM_WINESERVER="/usr/bin/wineserver"
#
# # ZSHRC のパス
# ZSHRC="$HOME/.zshrc"
#
# # 現在の設定を確認
# if grep -q "$PORTAL_WINE" "$ZSHRC"; then
#     # 現在 Wine 9 なので、Wine 11 (System) に切り替え
#     sed -i "s|export WINELOADER=\"$PORTAL_WINE\"|export WINELOADER=\"$SYSTEM_WINE\"|" "$ZSHRC"
#     sed -i "s|export WINESERVER=\"$PORTAL_WINESERVER\"|export WINESERVER=\"$SYSTEM_WINESERVER\"|" "$ZSHRC"
#     echo "🍷 Switched to Wine 11 (System Default)"
# else
#     # 現在 Wine 11 なので、Wine 9 (Portal) に切り替え
#     sed -i "s|export WINELOADER=\"$SYSTEM_WINE\"|export WINELOADER=\"$PORTAL_WINE\"|" "$ZSHRC"
#     sed -i "s|export WINESERVER=\"$SYSTEM_WINESERVER\"|export WINESERVER=\"$PORTAL_WINESERVER\"|" "$ZSHRC"
#     echo "🚀 Switched to Wine 9 (Portal/Stable)"
# fi
#
# # 設定を即座に反映
# source "$ZSHRC"
# # Yabridge を同期（Wineのバージョンが変わる時は必須！）
# yabridgectl sync
#

