
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
# Yabridge 

sudo pacman -S yabridge yabridgectl

yabridge-host.exe

# Add plugin location
yabridgectl add <plugin_location>

Ex: 
yabridgectl add "$HOME/.wine/drive_c/Program Files/Steinberg/VstPlugins"
yabridgectl add "$HOME/.wine/drive_c/Program Files/Common Files/VST3"
yabridgectl add "$HOME/.wine/drive_c/Program Files/Common Files/CLAP"

yabridgectl add "$HOME/.wine64/drive_c/Program Files/Steinberg/VSTPlugins"
yabridgectl add "$HOME/.wine64/drive_c/Program Files (x86)/VstPlugins"

# Convert plugins into .so
yabridgectl sync

# Check the status 
yabridgectl status



#
# Native Accesss
#
#
# https://appdb.winehq.org/objectManager.php?sClass=version&iId=41820&iTestingId=114427
# o
#
#


Installation Steps
# Run the Native Access installer
# The install will succeed then the application will automatically open, however this will show the "Setting up Native Access" message that lead to the permissions message ("Please grant permission to Native Access to install dependencies"), so close the application
# The install process will make the NTKDaemon installer available
# Run the NTKDaemon installer
# Located at "C:\Program Files\Native Instruments\Native Access\resources\daemon\win\NTKDaemon 1.14.0 Setup PC.exe" (or whichever the current version is)
# This should automatically start the NTKDaemon after install, but the NTKDaemon can also be started manually 
# Move the "Native Access.desktop" entry from "~/.local/share/applications/wine/Programs" to "~/.local/share/applications"
# Update the "Native Access.desktop" entry: append `--remote-debugging-port=9222 %u` to the `Exec` field
# Eg. `Exec=env WINEPREFIX="/home/user/.wine" wine C:\\\\users\\\\user\\\\AppData\\\\Roaming\\\\Microsoft\\\\Windows\\\\Start\\ Menu\\\\Programs\\\\Native\\ Access.lnk --remote-debugging-port=9222 %u`
# Set this desktop entry as the default handler for the "native-access" scheme by running `xdg-mime default Native\ Access.desktop x-scheme-handler/native-access`
# Open a Chromium browser and navigate to the Remote Debugging page for that browser (e.g. "brave://inspect" or "chrome://inspect")
# Ensure the NTKDaemon is running
#
#
# Run the executable at "C:\Program Files\Common Files\Native Instruments\NTK\NTKDaemon.exe", if it is not running.
# Run Native Access using the desktop entry (ensuring it runs with the `--remote-debugging-port` argument)
# This should now show "User requires authentication" on startup, instead of "Setting up Native Access", then show the log in page
# Click on "Inspect" in the Chromium remote debugging window to open the DevTools for the running Native Access Electron app
# Click on the "Network" tab to view the outgoing requests
# Log in using your Native ID
# A failed request should show in the list, with the form: "native-access://authorize?code="
# Click on the request and copy the entire request URL
# Open a terminal and run `xdg-open` with the request URL (eg. `xdg-open native-access://authorize?code=abc123`)
# The request should be handled by the running Native Access instance and process the log in request
# You should now be logged in and see your library

#
WINEPREFIX=~/.wine64  wine 'C:\Program Files\Native Instruments\Native Access\resources\daemon\win\NTKDaemon 1.14.0 Setup PC.exe'
# 根據您的版本號可能略有不同

WINEPREFIX=~/.wine_64 wine 'C:\Program Files\Common Files\Native Instruments\NTK\NTKDaemon.exe' &

#
Exec=env WINEPREFIX="/home/jialong/.wine64" wine C:\\\\users\\\\jialong\\\\AppData\\\\Roaming\\\\Microsoft\\\\Windows\\\\Start\ Menu\\\\Programs\\\\Native\ Access.lnk --remote-debugging-port=9222 %u

Exec=env WINEPREFIX="/home/jialong/.wine64" wine C:\\users\\jialong\\AppData\\Roaming\\Microsoft\\Windows\\Start\ Menu\\Programs\\Native\ Access.lnk --remote-debugging-port=9222 %u

Exec=env WINEPREFIX="/home/jialong/.wine64" wine Native\ Access.lnk --remote-debugging-port=9222 %u



# JH Piano
# https://plugins4free.com/plugin/3573/

# Darksichord
# https://plugins4free.com/plugin/3149/

# MT Power Drum Kit
# https://plugins4free.com/plugin/2783/

# rundll32.exe this application could not be started
#
WINEPREFIX=~/.wine64 winetricks -q corefonts mdac28


# WINEPREFIX=~/.wine64 wine appdefaults add "VSCO2 Orchestra.so" d2d1 ""
