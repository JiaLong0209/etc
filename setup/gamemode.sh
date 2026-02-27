# sudo pacman -S gamemode
sudo pacman -S gamemode lib32-gamemode

sudo pacman -S mangohud


# usage: gamemoderun %command%
# gamemoderun mangohud lutris

# launch game by id 
# gamemoderun mangohud lutris lutris:rungameid/1

# もしうまく表示されないとき
# 以下のように環境変数を指定して直接起動するのもおすすめです：
#
# env MANGOHUD=1 gamemoderun lutris
#

# lutris
sudo pacman -S lib32-mesa lib32-vulkan-icd-loader lib32-vkd3d

yay -S dxvk-bin

# Game options
unset LD_PRELOAD; \
WINEFSYNC=1 \
gamemoderun \
PROTON_ENABLE_NVAPI=1 \
# MANGOHUD=1 \ 
# MANGOHUD_CONFIG=fps_limit=100 \
# DXVK_ASYNC=1 \

%command%

unset LD_PRELOAD; WINEFSYNC=1 gamemoderun PROTON_ENABLE_NVAPI=1 %command%
unset LD_PRELOAD; WINEFSYNC=1 MANGOHUD=1 gamemoderun PROTON_ENABLE_NVAPI=1 gamescope -W 1920 -H 1200 -f --force-grab-cursor -- %command%


unset LD_PRELOAD;DXVK_ASYNC=1 WINEFSYNC=1 MANGOHUD=1 gamemoderun PROTON_ENABLE_NVAPI=1 gamescope -W 1920 -H 1200 -f --force-grab-cursor -- %command%

LD_PRELOAD= GL_SHADER_DISK_CACHE=1 GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1 GL_SHADER_DISK_CACHE_SIZE=100000000000 DXVK_ASYNC=1 __GL_THREADED_OPTIMIZATIONS=1 DXVK_ENABLE_PIPECOMPILER=1 DXVK_STATE_CACHE=1 PROTON_ENABLE_WAYLAND=1 PROTON_ENABLE_NVAPI=1 __GL_SYNC_TO_VBLANK=0 DXVK_ASYNC_MAX_QUEUED_FRAMES=8 __GL_SORT_FIFO=1 WINE_CPU_TOPOLOGY=8:0,1,2,3,4,5,6,7 nice --11 RunIsolated %command%
