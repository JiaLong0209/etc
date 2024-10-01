#!/bin/bash
#  ____                               _           _    
# / ___|  ___ _ __ ___  ___ _ __  ___| |__   ___ | |_  
# \___ \ / __| '__/ _ \/ _ \ '_ \/ __| '_ \ / _ \| __| 
#  ___) | (__| | |  __/  __/ | | \__ \ | | | (_) | |_  
# |____/ \___|_|  \___|\___|_| |_|___/_| |_|\___/ \__| 
#                                                      
# Based on https://github.com/hyprwm/contrib/blob/main/grimblast/screenshot.sh 
# ----------------------------------------------------- 

# Screenshots will be stored in $HOME by default.
# The screenshot will be moved into the screenshot directory

# Add this to ~/.config/user-dirs.dirs to save screenshots in a custom folder: 
# XDG_SCREENSHOTS_DIR="$HOME/Screenshots"

prompt='Screenshot'
mesg="DIR: ~/Screenshots"

 Screenshot Filename
source ~/.config/ml4w/settings/screenshot-filename.sh

# Screenshot Folder
source ~/.config/ml4w/settings/screenshot-folder.sh

# Screenshot Editor
export GRIMBLAST_EDITOR="$(cat ~/.config/ml4w/settings/screenshot-editor.sh)"

# Example for keybindings
# bind = SUPER, p, exec, grimblast save active
# bind = SUPER SHIFT, p, exec, grimblast save area
# bind = SUPER ALT, p, exec, grimblast save output
# bind = SUPER CTRL, p, exec, grimblast save screen

# Options
option_1="Immediate"
option_2="Delayed"

option_capture_1="Capture Everything"
option_capture_2="Capture Active Display"
option_capture_3="Capture Selection"


list_col='1'
list_row='2'

copy='Copy'
save='Save'
copy_save='Copy & Save'
edit='Edit'

# Rofi CMD
rofi_cmd() {
  rofi -dmenu -replace -config ~/.config/rofi/config-screenshot.rasi -i -no-show-icons -l 2 -width 30 -p "Take screenshot"
}

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$option_1\n$option_2" | rofi_cmd
}
#
# CMD
type_screenshot_cmd() {
  rofi -dmenu -replace -config ~/.config/rofi/config-screenshot.rasi -i -no-show-icons -l 3 -width 30 -p "Type of screenshot"
}

# Ask for confirmation
type_screenshot_exit() {
  echo -e "$option_capture_1\n$option_capture_2\n$option_capture_3" | type_screenshot_cmd
}

# Confirm and execute
type_screenshot_run() {
  selected_type_screenshot="$(type_screenshot_exit)"
  option_type_screenshot=area
  ${1}
}
###

# Confirm and execute
copy_save_editor_run() {
  selected_chosen="$(copy_save_editor_exit)"
  option_chosen=copysave
  ${1}
}
###

# take shots
takescreenshot() {
  grimblast --notify "$option_chosen" "$option_type_screenshot" $NAME
  if [ -f $HOME/$NAME ] ;then
    if [ -d $screenshot_folder ] ;then
      mv $HOME/$NAME $screenshot_folder/
    fi
  fi
}


# Execute Command
run_cmd() {
  option_type_screenshot=area
  copy_save_editor_run "takescreenshot"
}
# Actions

run_cmd 


