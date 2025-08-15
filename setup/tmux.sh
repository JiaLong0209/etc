sudo pacman -S tmux

echo "clone tpm repo..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "copy ./tmux.conf to ~/.tmux.conf"
cp ./tmux.conf ~/.tmux.conf

tmux 
# press ctrl + b and I to install the plugins in tmux

