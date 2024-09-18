# Clearning Up On Garuda Linux

## Clear Package Cache

```bash
sudo paccache -r
# Disk saved 5.6 GiB
```

## Remove Orphaned Packages

```bash
sudo pacman -Qdtq | sudo pacman -Rns - 
```

## Clean up the AUR
```bash
yay -Yc
# Total Removed Size: 668.74 MiB
```

## Clean Pacman Cache Manually
```bash
# Pacman’s cache, located at /var/cache/pacman/pkg
sudo paccache -rk1
# 1010 packages removed (disk space saved: 8.22 GiB)
```
## Remove Old Kernels
```bash

mhwd-kernel -li

sudo pacman -R linux<kernel_version>
```

## Delete Old Configuration Files
```bash
find ~/.config -type f -mtime +365 -exec rm {} \;
```
