# sudo pacman -S reflector rsync

# sudo reflector --latest 10 --sort rate --fastest 5 --save /etc/pacman.d/mirrorlist

sudo reflector --latest 20 --sort rate --fastest 10 --save /etc/pacman.d/mirrorlist

# sudo reflector --country "TW, JP" --latest 20 --sort rate --fastest 10 --save /etc/pacman.d/mirrorlist
