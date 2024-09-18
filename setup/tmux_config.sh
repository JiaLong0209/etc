sudo pacman -S tmux

echo "clone tpm repo..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "copy ./tmux.conf to ~/.tmux.conf"
cp ./tmux.conf ~/.tmux.conf

echo "Restart tmux..."
tmux kill-server
tmux 

