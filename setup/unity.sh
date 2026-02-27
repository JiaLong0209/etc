#
# yay -S unityhub
#
# sudo pacman -S libfuse2
#

mkdir ~/src
cd ~/src
git clone https://aur.archlinux.org/unityhub.git
cd unityhub
makepkg -is

# install .NET SDK
sudo pacman -S dotnet-sdk dotnet-runtime
