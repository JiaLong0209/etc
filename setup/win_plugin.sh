
# 1. Install Wine
sudo pacman -S wine winetricks
# Make sure your Wine prefix is 64-bit (needed for most VSTs nowadays). You can create a fresh one like this:

WINEPREFIX=~/.wine64 WINEARCH=win64 winecfg

# 2. Run the OTT installer
# Assuming you downloaded Install_Xfer_OTT_137.exe, run:

WINEPREFIX=~/.wine64 wine Install_Xfer_OTT_137.exe

~/.wine64/drive_c/Program Files/VstPlugins

~/.wine64/drive_c/Program Files/Steinberg/VSTPlugins

Make note of where it installs the OTT.dll.


# The locations of VST3 on window .vst3
# C:\Program Files\Common Files\VST3
# 32-bit VST3 plug-ins on 64-bit Windows: C:\Program Files (x86)\Common Files\VST3

# The locations of VST2 on window .dll
#
#	C:\Program Files\VSTPlugins
# C:\Program Files\Steinberg\VSTPlugins
# C:\Program Files\Common Files\VST2
# C:\Program Files\Common Files\Steinberg\VST2
# 32-bit plug-ins on 64-bit Windows: C:\Program Files (x86)\Steinberg\VstPlugins
#
#

# Yabridge 

sudo pacman -S yabridge yabridgectl

yabridge-host.exe

# Add plugin location
yabridgectl add <plugin_location>

Ex: 
yabridgectl add "$HOME/.wine/drive_c/Program Files/Steinberg/VstPlugins"
yabridgectl add "$HOME/.wine/drive_c/Program Files/Common Files/VST3"
yabridgectl add "$HOME/.wine/drive_c/Program Files/Common Files/CLAP"

# Convert plugins into .so
yabridgectl sync

# Check the status 
yabridgectl status



#
# Native Accesss
#
# https://appdb.winehq.org/objectManager.php?sClass=version&iId=41820&iTestingId=114427

Exec=env WINEPREFIX="/home/jialong/.wine" wine C:\\\\users\\\\jialong\\\\AppData\\\\Roaming\\\\Microsoft\\\\Windows\\\\Start\ Menu\\\\Programs\\\\Native\ Access.lnk --remote-debugging-port=9222 %u

Exec=env WINEPREFIX="/home/jialong/.wine" wine C:\\users\\jialong\\AppData\\Roaming\\Microsoft\\Windows\\Start\ Menu\\Programs\\Native\ Access.lnk --remote-debugging-port=9222 %u

Exec=env WINEPREFIX="/home/jialong/.wine" wine Native\ Access.lnk --remote-debugging-port=9222 %u




