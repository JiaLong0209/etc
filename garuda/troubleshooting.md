# Trouble Shooting

## Can't boot after update system


### Using Live USB 

```bash

# mount root 
sudo mount -o subvol=@ /dev/nvme0n1p6 /mnt

# mount /boot/efi
sudo mount /dev/nvme0n1p1 /mnt/boot/efi

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


