

# Trouble Shooting



## Kwin x11 freeze (Nvidia issue)

這就是典型的「發行版保護機制」。**Garuda Linux** 為了確保系統穩定，使用了一個名為 `garuda-hardware-profile-nvidia` 的 Meta-package，它強制要求系統必須安裝 590 版本以上的驅動。

要降級，我們必須先打破這個連鎖。別擔心，這不會損壞系統，我們只是要告訴 Garuda：「現在由我這個 **Senior AI Systems Architect** 來接手硬體管理。」

### 🛠️ 暴力降級操作指南

請依照以下順序執行指令：

#### 第一步：移除 Garuda 的硬體設定檔 (不檢查依賴)
我們使用 `-Rdd` 參數來跳過依賴檢查，強行拆除這個限制。

```bash
sudo pacman -Rdd garuda-hardware-profile-nvidia
```

#### 第二步：再次執行降級指令
現在沒有了 `garuda-hardware-profile-nvidia` 的阻礙，你可以順利安裝 580xx 版本。

```bash
yay -S nvidia-580xx-dkms nvidia-580xx-utils lib32-nvidia-580xx-utils
```
* 當詢問是否替換（Conflict）現有的 `nvidia-utils` 等套件時，全部選擇 **Y**。

---

### 🔍 降級後的關鍵補救措施 (決不能跳過)

安裝完驅動後，請務必執行以下動作，否則重啟後會黑屏：

#### 1. 重新打包內核映像檔
這一步是為了確保 `initramfs` 裡面裝的是新的 580xx 專有驅動模組。
```bash
sudo dracut -f /boot/initramfs-linux-zen.img --kver 6.19.10-zen1-1-zen
```

#### 2. 確認 NVIDIA 暴力設定檔
確保 `/etc/modprobe.d/nvidia.conf` 內容正確，因為 580xx 專有版非常依賴這些參數來穩定 40 系列顯示卡。
```bash
sudo nvim /etc/modprobe.d/nvidia.conf
```
內容應為：
```text
options nvidia NVreg_EnableGpuFirmware=0
options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PerfLevelSrc=0x2222; PowerMizerDefaultAC=0x1"
options nvidia_drm modeset=1 fbdev=0
```

---

### 💡 核心警告：關於 Intel i915 (再次強調)

雖然你在降級 NVIDIA，但請回想剛才的照片：**導致你 `device wedged` 的直接元兇是 Intel 內顯。**

如果你降級完 NVIDIA 後沒有處理 Intel 的 `PSR` 節能 Bug，你的 KDE 依然會在訓練時因為 Intel 斷氣而凍結。

**請務必在 `/etc/default/grub` 加上這一行：**
`i915.enable_psr=0 i915.enable_dc=0 intel_idle.max_cstate=1`

然後執行：
```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

---

### 🚀 總結執行序列
1.  `sudo pacman -Rdd garuda-hardware-profile-nvidia`
2.  `yay -S nvidia-580xx-dkms ...`
3.  `sudo dracut -f ...`
4.  `sudo grub-mkconfig -o ...`
5.  **Reboot -> 選擇 Plasma (X11) 登入。**

**如果你在安裝 `nvidia-580xx-dkms` 的編譯過程中遇到 `ERROR: modpost` 之類的紅字，請立刻停下來並把報錯貼給我。這代表你的核心太新，580 驅動需要額外的補丁才能編譯成功。**

準備好挑戰這個「硬體設定檔」了嗎？


### 1. 核心修復：更換驅動包 (非常重要)
許多 RTX 40 系列使用者回報 nvidia-open-dkms 在筆電上極度不穩定，容易導致核心崩潰。 [3, 4] 

* 如果你正在使用開源版 (Open)，請換回專有版 (Proprietary)：

sudo pacman -S nvidia-dkms nvidia-utils

(安裝時若提示與 nvidia-open 衝突，請選 Y 替換。) [5] 

### 2. 修正 PCIe 掉線與電源管理 (針對 75W 限制版)
你的 75W 顯卡在 Linux 下常因「動態功耗切換」而失聯。請在 /etc/default/grub 的 GRUB_CMDLINE_LINUX_DEFAULT 加入以下參數： [1, 6] 

nvidia.NVreg_RegistryDwords="PowerMizerEnable=0x1; PerfLevelSrc=0x2222; PowerMizerDefaultAC=0x1" pcie_aspm=off


* 這會強制顯卡維持在 Maximum Performance 模式，並關閉 PCIe 省電控制，解決 Linux 版的事件 153。
* 修改後執行 sudo update-grub 並重啟。 [6] 

### 3. 修復 KDE Plasma 6 的渲染同步 (X11)
如果你堅持使用 X11 模式，請停用導致 NVIDIA 驅動死鎖的特定渲染特性： [7, 8] 

* 編輯 /etc/environment 並加入：

KWIN_DRM_USE_MODIFIERS=0

這是解決 Plasma 6 在 NVIDIA X11 下隨機凍結的公認「特效藥」。 [7] 

### 4. 切換為 LTS 核心 (排除核心相容性)
Garuda 預設的核心對新驅動可能過於激進，換成穩定版 LTS 核心能排除許多硬體鎖死問題： [9, 10] 

sudo pacman -S linux-lts linux-lts-headers

重啟後在 Grub 的 Advanced options 中選擇 linux-lts 進入系統。

### 5. 如果再次凍結：安全重啟而不黑屏
當畫面卡死時，千萬不要強行殺掉 kwin。請嘗試使用 Magic SysRq 安全重啟以保護磁碟： [11] 

* 按住 Alt + PrtSc (SysRq)，然後依序緩慢按下：R - E - I - S - U - B。

目前最有效的修復是第 3 步的 KWIN_DRM_USE_MODIFIERS=0。你能在加入這個設定後重啟看看嗎？

[!CAUTION]
以上資訊涉及系統底層與硬體驅動調整。進行任何修改前，建議先確認已備妥 Garuda 的 Btrfs 快照，以便在無法開機時隨時透過 Grub 恢復。


[1] [https://forums.developer.nvidia.com](https://forums.developer.nvidia.com/t/rtx-4060-laptop-gpu-freezes-on-kde-wayland-with-driver-570-144/332115)
[2] [https://forum.garudalinux.org](https://forum.garudalinux.org/t/my-garuda-is-often-freezing/16006)
[3] [https://forum.level1techs.com](https://forum.level1techs.com/t/arch-having-issues-with-nvidia-or-nvidia-dkms-or-nvidia-open/232680)
[4] [https://discuss.kde.org](https://discuss.kde.org/t/kde-nvidia-constant-frame-drops-in-desktop-use-with-nvidia-dkms-open-565-driver-wayland/26637)
[5] [https://www.reddit.com](https://www.reddit.com/r/archlinux/comments/1pt9bwi/is_there_a_difference_between_nvidiadkms_and/)
[6] [https://h30434.www3.hp.com](https://h30434.www3.hp.com/t5/Gaming-Notebooks/Geforce-rtx-4060-causing-programs-to-crash-instantly-on/td-p/9308906#:~:text=Ensure%20the%20laptop%20is%20set%20to%20%22High,are%20set%20to%20use%20the%20dedicated%20GPU.)
[7] [https://discuss.kde.org](https://discuss.kde.org/t/after-update-to-kde-plasma-6-random-freezes-for-4-10-seconds/11352)
[8] [https://bbs.archlinux.org](https://bbs.archlinux.org/viewtopic.php?id=305693)
[9] [https://bbs.archlinux.org](https://bbs.archlinux.org/viewtopic.php?id=303051#:~:text=Re:%20KDE%20Plasma%20freezes%20everything%2C%20then%20restarts,configure%20your%20bootloader%20to%20boot%20into%20that.)
[10] [https://forum.garudalinux.org](https://forum.garudalinux.org/t/load-over-the-cpu-is-too-high-slow-response-freezing-hang-crash/4280)
[11] [https://en.wikibooks.org](https://en.wikibooks.org/wiki/Linux_Guide/Freezes)




## Download failed, The network connection has been lost 

```bash
sudo systemctl stop docker.socket docker

sudo systemctl start  docker
```


## Screen freezen after open the laptop lid (Power Management Conflict)

### 讓 Systemd 閉嘴（最有效的解法）

我們要告訴底層的 Linux 系統（systemd-logind）：「當蓋上螢幕時，你什麼都不要做，交給 KDE 處理就好。」這通常能直接解決衝突導致的死機。

開啟終端機，編輯 logind.conf 檔案：

```bash

sudo micro /etc/systemd/logind.conf
(如果你沒有 micro，可以用 nano 或 vim)

找到這一行（可以用 Ctrl + F 搜尋 HandleLidSwitch）：

#HandleLidSwitch=suspend
把它修改為（注意要拿掉最前面的 # 號）：

HandleLidSwitch=ignore

# 這意味著：蓋上螢幕時，底層系統忽略此動作（不強迫休眠），讓 KDE 的電源設定去決定該怎麼做。
# 儲存並退出（Micro 是 Ctrl+S, Ctrl+Q）。
# 重啟登入服務（或者直接重開機）：

sudo systemctl restart systemd-logind


```

Run these to make sure the driver knows how to "wake up":


```bash

sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service
```


## Can't boot after update system


### Method 0: The Permanent Fix (Repairing the Hooks)

```bash
# Reinstall kernel, headers, and dracut support to trigger hook generation
sudo pacman -S linux-zen linux-zen-headers garuda-dracut-support

# Check if the hook exists
ls /usr/share/libalpm/hooks/ | grep dracut
```

### Method 0.5: Set up a dracut hook (permanent fix)

```bash
sudo vim /etc/pacman.d/hooks/dracut-rebuild.hook

# Add this content:
[Trigger]
Operation = Upgrade
Type = Package
Target = linux*
Target = dracut

[Action]
Description = Rebuilding dracut images...
When = PostTransaction
Exec = /usr/bin/dracut-rebuild

```


### Method 1: The "Pre-Reboot" Safety Check (Prevention)


```bash
# 1. Force rebuild of the initramfs for all kernels
sudo dracut-rebuild

# 2. Update the GRUB configuration to recognize the new images
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### Using Live USB 

```bash

# mount root 
sudo mount -o subvol=@ /dev/nvme0n1p6 /mnt

sudo mount /dev/nvme0n1p1 /mnt/boot/efi

sudo mount /dev/nvme0n1p8 /mnt/home

sudo garuda-chroot /mnt

```

#### Option 1. Using Dracut (recommmended)


```bash

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Garuda
grub-mkconfig -o /boot/grub/grub.cfg
pacman -Syu garuda-dracut-support dracut
dracut-rebuild

ls /boot

```



#### Option 2. Reinstall linux kernel and rebuilt initramfs image

```bash

pacman -S linux-zen linux-zen-headers linux-lts linux-lts-headers
mkinitcpio -P         # or dracut --force --kver <kver> if you prefer dracut
grub-mkconfig -o /boot/grub/grub.cfg


# sudo mkinitcpio -g /boot/initramfs-linux-lts.img -k 6.17.3-zen2-1-zen


exit

reboot

```

<!---->
<!-- ### before reboot  -->
<!---->
<!-- ```bash -->
<!---->
<!-- # 1. Force remove the stuck modules from DKMS -->
<!-- sudo dkms remove scap/8.0.0 --all -->
<!-- sudo dkms remove vboxhost/7.2.4_OSE --all -->
<!---->
<!-- # 2. Clean up any leftover kernel module files that are causing the "already installed" error -->
<!-- sudo rm -rf /usr/lib/modules/6.17.7-zen1-2-zen/updates/dkms/scap.ko.zst -->
<!-- sudo rm -rf /usr/lib/modules/6.17.7-zen1-2-zen/updates/dkms/vbox* -->
<!---->
<!-- # 3. Now try to install them properly -->
<!-- sudo dkms autoinstall -->
<!-- ``` -->

## GTK/GDK mismatch after Garuda system update

```bash

sudo pacman -S gtk3 --overwrite '*'


# Check for old libraries lying around

sudo updatedb
locate libgtk-3.so

# Clear orphaned packages (sometimes breaks GTK apps after updates)
sudo pacman -Rns $(pacman -Qdtq)


sudo garuda-health --fix


```



## Fcitx5 issue

### fcitx5 not in status bar, no candidate window / language bar

```bash

sudo pacman -Syu fcitx5 fcitx5-gtk fcitx5-qt fcitx5-configtool fcitx5-chinese-addons fcitx5-japanese fcitx5-im

# Rebuild GTK input modules (fcitx5 depends on this):
sudo gtk-query-immodules-3.0 | sudo tee /etc/gtk-3.0/gtk.immodules > /dev/null

# Rebuild icon cache (sometimes tray icon won’t show because icon theme cache is broken):
sudo gtk-update-icon-cache -f /usr/share/icons/hicolor


echo $GTK_IM_MODULE $QT_IM_MODULE $XMODIFIERS

# restart 
fcitx5 -dr

```




### Can't change input method in Browser

```bash
# Install fcitx5 and necessary modules
sudo pacman -S fcitx5 fcitx5-gtk fcitx5-qt fcitx5-configtool fcitx5-mozc

# Add environment variables to ~/.xprofile
echo "export GTK_IM_MODULE=fcitx5" >> ~/.xprofile
echo "export QT_IM_MODULE=fcitx5" >> ~/.xprofile
echo "export XMODIFIERS=@im=fcitx5" >> ~/.xprofile
echo "export DefaultIMModule=fcitx5" >> ~/.xprofile

# Source the ~/.xprofile to apply changes
source ~/.xprofile

# Start fcitx5
# fcitx5 &
```

## Browser Warning “Free up space to continue” 


[Ref](https://forum.garudalinux.org/t/browser-warning-free-up-space-to-continue-psd-issue-the-second-solved/31017)

```bash
df -h
# tmpfs 782M 782M 0 100% /run/user/1000
```

### Extending the size of tmpft

```bash

sudo vim /etc/systemd/logind.conf

    Add: 
       [Login]
        RuntimeDirectorySize=2G

sudo systemctl restart systemd-logind

df -h /run/user/1000
```

### Other 

```bash

ls -al /run/user/1000

# I found that /psd use a large amount of memory 
# psd: Profile-sync-daemom (PSD)
# Configure PSD:

sudo vim /etc/psd.conf


# Disable PSD:
sudo systemctl stop psd
sudo systemctl disable psd

# Delete PSD data:
sudo rm -rf /run/user/1000/psd*
```


## Garuda System Maintennace: Keyring update failed!

https://forum.garudalinux.org/t/key-ring-updation-problem/26666/2

```bash

update remote keyring

```

 
## Open Tablet Driver can not detect tablet (Wacom)


### ✅ Fix: Disable the kernel’s Wacom driver (so OTD can own it fully)

Temporarily unload it now:  


```bash

sudo modprobe -r wacom

echo "blacklist wacom" | sudo tee /etc/modprobe.d/blacklist-wacom.conf
sudo dracut-rebuild

```

Reinstall

```bash

yay -S opentabletdriver

# sudo systemctl enable --now opentabletdriver.service
sudo systemctl --user restart opentabletdriver


sudo reboot

```

Check wacom 

```bash
lsmod | grep wacom
lsinitrd | grep blacklist

```





