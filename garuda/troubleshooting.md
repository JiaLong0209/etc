# Trouble Shooting

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





