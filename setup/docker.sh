
sudo pacman -S docker

sudo systemctl start docker.service

# Starts automatically when you system boots
sudo systemctl enable docker.service


# Add user to docker group 


sudo usermod -aG docker $USER

# take effect for the above change, you also can log out and log back
newgrp docker
