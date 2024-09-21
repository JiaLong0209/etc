killall -9 termux-x11 Xwayland pulseaudio virgl_test_server_android termux-wake-lock

# 啟動Termux X11
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity
XDG_RUNTIME_DIR=${TMPDIR}
termux-x11 :0 -ac &
sleep 3

# 啟動PulseAudio
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1
pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1

# 啟動GPU加速的virglserver
virgl_test_server_android &

# 登入proot Ubuntu並啟動桌面環境，注意最後面的startxfce4是用於啟動XFCE4桌面的。
proot-distro login ubuntu --user user --shared-tmp -- bash -c "export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1; dbus-launch --exit-with-session startxfce4"
# proot-distro login ubuntu --user user --shared-tmp -- bash -c "export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1; dbus-launch --exit-with-session startplasma-x11"


