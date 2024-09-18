#!/bin/bash
sonic-pi 
echo "Restart pulseaudio..."
systemctl --user restart pulseaudio
echo "Restart pulseaudio finished!"
