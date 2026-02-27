sudo pacman -S lsp-plugins

sudo pacman -S calf


# Synthesizer with classic instrument emulations
sudo pacman -S zynaddsubfx

# Sample-based player (load orchestral/classical SFZ instruments)
sudo pacman -S sfizz

# GM/GS SoundFont player (classic MIDI synth, piano, strings, brass, etc.)
sudo pacman -S fluidsynth qsampler

# Vital or Surge XT
# Modern synths, but good for classical-style patches
yay -S vital-synth-bin     # Proprietary version with GUI
sudo pacman -S surge-xt    # Free and open-source

# Host for LV2/VST plugins (standalone or inside DAWs)
sudo pacman -S carla carla-plugins

# Professional sampler (uses GIG/SFZ libraries)
yay -S linuxsampler gigedit


# x42 midifilter plugin
yay -S midifilter.lv2-git


# dexed

sudo -S dexed
# Keyzone Classic
