# Start KDE normally (on boot → SDDM login → Plasma).
# You’re now on TTY1 and display :0.
#
# Press Ctrl + Alt + F2 to go to another TTY.
#
# Log in (terminal).
#
# Start a new X session manually for XFCE:


# Enable LightDm
sudo systemctl disable sddm
sudo systemctl enable lightdm --force





startxfce4 -- :1 vt2

#
# This launches a second graphical environment on display :1.
#
# Switch between them:
#
# Ctrl + Alt + F1 → back to KDE
#
# Ctrl + Alt + F2 → XFCE


# Switching back to KDE
# You can switch back later with 

sudo systemctl enable sddm --force
sudo systemctl disable lightdm

# sudo reboot
