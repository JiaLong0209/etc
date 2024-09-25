# Ref: https://www.youtube.com/watch?v=Sibpj_o3cOI
#
# sudo pacman -S alacritty dolphin
sudo pacman -S waybar wofi hyprpaper ttf-font-awesome

# Configuration
vim ~/.config/hypr/hyprland.conf

# Wallpaper
vim ~/.config/hypr/hyprpaper.conf

# preload = <image_path>
# wallpaper = <image_path>

mkdir ~/.config/waybar

cp /etc/xdg/waybar/config.jsonc ~/.config/waybar/

# Waybar
vim ~/.config/waybar/config.jsonc

# Disable sddm
sudo systemctl disable sddm.service




