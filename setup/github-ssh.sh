ssh-keygen -t rsa -b 4096 -C "smt02091395@gmail.com"

# ssh agent (optional)
eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_rsa

# Copy the ssh key to github 
cat ~/.ssh/id_rsa.pub


