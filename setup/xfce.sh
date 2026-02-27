

# (you can skip “goodies” if you want minimal)
sudo pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter

# Enable LightDm
sudo systemctl disable sddm
sudo systemctl enable lightdm --force


# Switching back to KDE
# You can switch back later with 
sudo systemctl enable sddm --force
sudo systemctl disable lightdm

# Swtiching to GNOME
sudo systemctl enable gdm.service -f

sudo reboot


