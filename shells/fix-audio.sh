#!/usr/bin/env bash

# ==============================================================================
# Script Name: fix-audio.sh
# Target OS: Garuda Linux / Arch Linux (KDE)
# Objective: Force-recover ALSA/PipeWire from deep kernel/hardware deadlocks 
#            provoked by automated host crashes (e.g., Reaper/yabridge/Wine VSTs)
#            WITHOUT triggering a system reboot.
# ==============================================================================

# Terminal color codes for discrete log tracking
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' 

echo -e "${BLUE}[1/5] Terminating rogue audio and virtualization processes...${NC}"
# Purge host audio processes, sub-threads, and virtualized Wine runtimes immediately
killall -9 wireplumber pipewire pipewire-pulse reaper wine-preloader wineserver 2>/dev/null
# Force-sever active file descriptors clinging to raw hardware audio nodes
sudo fuser -k -9 /dev/snd/* 2>/dev/null

echo -e "${YELLOW}[2/5] Overriding kernel-level hardware power-saving locks...${NC}"
# Forcefully transition the sound controller out of un-scrollable D3 sleep states
echo "0" | sudo tee /sys/module/snd_hda_intel/parameters/power_save

echo -e "${YELLOW}[3/5] Triggering simulated hardware hotplug via udev subsystem...${NC}"
# Prompt the Linux kernel to re-initialize and perform a hard scan on the PCI bus
sudo udevadm trigger
sleep 1
sudo alsactl init

echo -e "${BLUE}[4/5] Purging corrupted runtime states and IPC sockets...${NC}"
# Erase transient cache targets and raw descriptors to bypass state corruption cycles
rm -rf ~/.local/state/wireplumber/*
rm -rf ~/.local/state/pipewire/*
rm -f /run/user/$(id -u)/pipewire-0*

echo -e "${GREEN}[5/5] Re-initializing systemd user-level audio infrastructure...${NC}"
# Force-sync systemd tracking maps, reset fail thresholds, and rebuild audio daemons
systemctl --user daemon-reload
systemctl --user reset-failed wireplumber pipewire pipewire-pulse 2>/dev/null
systemctl --user restart pipewire pipewire-pulse wireplumber

# Validate active daemon initialization status
sleep 1
if systemctl --user is-active --quiet wireplumber; then
    echo -e "${GREEN}==================================================${NC}"
    echo -e "${GREEN} SUCCESS: Audio infrastructure recovered without reboot. ${NC}"
    echo -e "${GREEN}==================================================${NC}"
else
    echo -e "${RED}FAILURE: WirePlumber failed to safely hook into the IPC layer.${NC}"
    exit 1
fi

