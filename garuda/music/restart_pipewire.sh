killall -9 pipewire pipewire-pulse wireplumber 2>/dev/null

# echo "0" | sudo tee /sys/module/snd_hda_intel/parameters/power_save

# 強制重新觸發 udev 硬體事件
sudo udevadm trigger

# 再次要求 ALSA 盲掃（這次注意看有沒有出現 HDMI 以外的內建喇叭硬體）
sudo alsactl init

systemctl --user daemon-reload
rm -rf ~/.local/state/wireplumber/* ~/.local/state/pipewire/*
systemctl --user restart pipewire pipewire-pulse wireplumber


