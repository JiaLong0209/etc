#!/bin/bash

# =================================================================
# Script: Universal Mouse Scroll Toggle
# Platform: Garuda Linux (KDE Plasma / X11)
# Purpose: Toggles "Middle Button Scrolling" for all pointer devices.
# =================================================================

# 1. Find all relevant device IDs (Mice, Touchpads, and Logitech receivers)
# We exclude "Keyboard" to avoid errors on multi-function USB receivers.
device_ids=$(xinput list | grep -E "Mouse|Touchpad|LogiOps|Logitech USB Receiver" | grep -v "Keyboard" | sed -r 's/.*id=([0-9]+).*/\1/')

# Variable to store the final status for the notification
final_status="Unknown"

# 2. Loop through each detected device ID
for id in $device_ids; do
    # Check if this specific device supports the "Scroll Method" property
    if xinput list-props "$id" | grep -q "libinput Scroll Method Enabled ("; then
        
        # 3. Get the current state (1 = Enabled, 0 = Disabled)
        # We look at the very last number in the property line
        current_state=$(xinput list-props "$id" | grep "libinput Scroll Method Enabled (" | awk '{print $NF}')
        
        # 4. Toggle the value
        if [ "$current_state" == "1" ]; then
            # If ON, turn it OFF
            # The '2>/dev/null' hides those "BadValue" errors you saw earlier
            xinput set-prop "$id" "libinput Scroll Method Enabled" 0 0 0 2>/dev/null
            final_status="DISABLED"
        else
            # If OFF, turn it ON
            xinput set-prop "$id" "libinput Scroll Method Enabled" 0 0 1 2>/dev/null
            final_status="ENABLED"
        fi
    fi

done

# 5. Send a single desktop notification so you know it worked
if [ "$final_status" != "Unknown" ]; then
    # notify-send "Mouse Settings" "Middle Button Scrolling is now $final_status, ID: $id" -t 2000
    notify-send "Mouse Settings" "Middle Button Scrolling is now $final_status" -t 2000
fi
