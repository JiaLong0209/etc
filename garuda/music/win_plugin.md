
# Windows VST plugins Troubleshooting


## VST plugin black UI
Vulkan 抜き Symlink Prefix 構築コマンド


```bash
# 1. 新しい Prefix フォルダを作成
mkdir -p ~/.wine_no_vulkan/drive_c/windows
cd ~/.wine_no_vulkan

# 2. 基本構造をコピー＆リンク
cp -r ~/.wine64/dosdevices ~/.wine_no_vulkan/
rm ~/.wine_no_vulkan/dosdevices/c:
ln -s ~/.wine_no_vulkan/drive_c ~/.wine_no_vulkan/dosdevices/c:
cp ~/.wine64/*.reg ~/.wine_no_vulkan/

# 3. drive_c の主要フォルダをリンク (容量節約)
ln -s ~/.wine64/drive_c/ProgramData ~/.wine_no_vulkan/drive_c/
ln -s ~/.wine64/drive_c/users ~/.wine_no_vulkan/drive_c/
ln -s ~/.wine64/drive_c/"Program Files (x86)" ~/.wine_no_vulkan/drive_c/
ln -s ~/.wine64/drive_c/"Program Files" ~/.wine_no_vulkan/drive_c/

# 4. Windows フォルダの中身を全てリンク
for d in ~/.wine64/drive_c/windows/*; do ln -s "$d" ~/.wine_no_vulkan/drive_c/windows/; done

# 5. system32 と syswow64 だけは「独立」させて DLL を入れ替える
rm ~/.wine_no_vulkan/drive_c/windows/system32 ~/.wine_no_vulkan/drive_c/windows/syswow64
mkdir -p ~/.wine_no_vulkan/drive_c/windows/system32 ~/.wine_no_vulkan/drive_c/windows/syswow64

# 全てのファイルをリンク
for d in ~/.wine64/drive_c/windows/syswow64/*; do ln -s "$d" ~/.wine_no_vulkan/drive_c/windows/syswow64/; done
for d in ~/.wine64/drive_c/windows/system32/*; do ln -s "$d" ~/.wine_no_vulkan/drive_c/windows/system32/; done

# 6. Vulkan/DXVK 関連のリンクを削除して、Wine 標準 DLL を強制適用
# (これで Keyzone の黒画面を防ぐ)
for dir in system32 syswow64; do
    cd ~/.wine_no_vulkan/drive_c/windows/$dir
    rm -f d3d9.dll d3d10core.dll d3d11.dll dxgi.dll d2d1.dll
    # Wine 本体の DLL を使うように設定 (Native Access とは隔離)
    WINEPREFIX=~/.wine_no_vulkan winecfg /v win10
done

# 7. Yabridge にこの環境で Keyzone を動かすよう命令
yabridgectl set --plugin "Keyzone Classic" --option "wineprefix=/home/jialong/.wine_no_vulkan"
yabridgectl sync



```
