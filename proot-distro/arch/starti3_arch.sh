#!/data/data/com.termux/files/usr/bin/bash

USER=$1

if [[ -z $USER ]]; then
  USER="user"
fi

# Kill open X11 processes
kill -9 $(pgrep -f "termux.x11") 2>/dev/null

virgl_test_server_android &
#
# Enable PulseAudio over Network
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

# Prepare termux-x11 session
export XDG_RUNTIME_DIR=${TMPDIR}
termux-x11 :0 >/dev/null &

proot-distro login archlinux --user $USER --shared-tmp  -- /bin/bash -c  'export PULSE_SERVER=127.0.0.1 && export XDG_RUNTIME_DIR=${TMPDIR} && su -l $USER -c "env DISPLAY=:0 i3"'

exit 0
