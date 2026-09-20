#!/usr/bin/env bash

# Terminal color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}[1/5] Terminating rogue audio and virtualization processes...${NC}"
# 關閉所有 Sockets 與 Services
systemctl --user stop pipewire.socket pipewire-pulse.socket wireplumber.service pipewire.service pipewire-pulse.service 2>/dev/null
killall -9 wireplumber pipewire pipewire-pulse reaper easyeffects wine-preloader wineserver 2>/dev/null
sudo fuser -k -9 /dev/snd/* 2>/dev/null

echo -e "${YELLOW}[2/5] Overriding kernel-level hardware power-saving locks...${NC}"
echo "0" | sudo tee /sys/module/snd_hda_intel/parameters/power_save 2>/dev/null || true

echo -e "${YELLOW}[3/5] Re-initializing ALSA hardware...${NC}"
sudo alsactl init 2>/dev/null || true

echo -e "${BLUE}[4/5] Purging corrupted runtime states and IPC sockets...${NC}"
rm -f /run/user/$(id -u)/pipewire-0*
rm -f /run/user/$(id -u)/pulse/*
rm -rf ~/.local/state/wireplumber/*
rm -rf ~/.local/state/pipewire/*
rm -rf ~/.cache/wireplumber/*

echo -e "${GREEN}[5/5] Rebuilding systemd user-level audio infrastructure...${NC}"
systemctl --user daemon-reload
systemctl --user reset-failed wireplumber pipewire pipewire-pulse

# 依序啟動 Socket 與 Service
systemctl --user start pipewire.socket pipewire.service
systemctl --user start pipewire-pulse.socket pipewire-pulse.service
sleep 1
systemctl --user start wireplumber.service

sleep 1
if systemctl --user is-active --quiet wireplumber; then
    echo -e "${GREEN}==================================================${NC}"
    echo -e "${GREEN} SUCCESS: Audio infrastructure recovered cleanly! ${NC}"
    echo -e "${GREEN}==================================================${NC}"
    wpctl status
else
    echo -e "${RED}FAILURE: WirePlumber failed to safely hook into the IPC layer.${NC}"
    exit 1
fi
