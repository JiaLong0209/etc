
apt update
apt install sudo vim software-properties-common

# disable snap store
# cat <<EOF | sudo tee /etc/apt/preferences.d/nosnap.pref
# # To prevent repository packages from triggering the installation of Snap,
# # this file forbids snapd from being installed by APT.
# # For more information: https://linuxmint-user-guide.readthedocs.io/en/latest/snap.html
# Package: snapd
# Pin: release a=*
# Pin-Priority: -10
# EOF
#

# update mirrorlist 
sudo sed -i 's/ports.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list
apt update 

# set password
passwd 

# add new user
groupadd storage
groupadd wheel
groupadd video
useradd -m -g users -G wheel,audio,video,storage -s /bin/bash user
passwd user

visudo
# put user ALL=(ALL:ALL) ALL

# install xfce4
sudo apt install xubuntu-desktop
sudo update-alternatives --config x-terminal-emulator

# install KDE
# sudo apt install kubuntu-desktop
# sudo update-alternatives --config x-terminal-emulator

# set time zone
sudo ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime

# install fcitx5
sudo apt install locales fcitx5* fonts-noto-cjk

# use zh_TW UTF-8
locale-gen
echo "LANG=zh_TW.UTF-8" > /etc/locale.conf

vim ~/.profile
# put 
# LANG=zh_TW.UTF-8
# LC_CTYPE=zh_TW.UTF-8
# LC_NUMERIC=zh_TW.UTF-8
# LC_TIME=zh_TW.UTF-8
# LC_COLLATE=zh_TW.UTF-8
# LC_MONETARY=zh_TW.UTF-8
# LC_MESSAGES=zh_TW.UTF-8
# LC_PAPER=zh_TW.UTF-8
# LC_NAME=zh_TW.UTF-8
# LC_ADDRESS=zh_TW.UTF-8
# LC_TELEPHONE=zh_TW.UTF-8
# LC_MEASUREMENT=zh_TW.UTF-8
# LC_IDENTIFICATION=zh_TW.UTF-8
# LC_ALL=
#
# GTK_IM_MODULE=fcitx
# QT_IM_MODULE=fcitx
# XMODIFIERS=@im=fcitx
# SDL_IM_MODULE=fcitx
# GLFW_IM_MODULE=ibus
# fcitx5 &

mkdir ~/.shortcuts
vim ~/.shortcuts/startproot_ubuntu.sh

# put 
#
# #!/bin/bash
# 中止所有舊行程
# killall -9 termux-x11 Xwayland pulseaudio virgl_test_server_android termux-wake-lock
#
# # 啟動Termux X11
# am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity
# XDG_RUNTIME_DIR=${TMPDIR}
# termux-x11 :0 -ac &
# sleep 3
#
# # 啟動PulseAudio
# pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1
# pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1
#
# # 啟動GPU加速的virglserver
# virgl_test_server_android &
#
# # 登入proot Ubuntu並啟動桌面環境，注意最後面的startxfce4是用於啟動XFCE4桌面的。
# proot-distro login ubuntu --user user --shared-tmp -- bash -c "export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1; dbus-launch --exit-with-session startxfce4"
#

chmod +x ~/.shortcuts/startproot_ubuntu.sh



