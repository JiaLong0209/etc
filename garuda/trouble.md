# Trouble Shooting

## Can't change input method in Browser

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




