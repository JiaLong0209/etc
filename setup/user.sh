#!/bin/bash

user_name=$1

if [[ -z $user_name ]]; then 
  echo "Usage: $0 <USER_NAME>"
  exit 1
fi

echo "useradd -m -G wheel $user_name ..."
useradd -m -G wheel $user_name

echo "passwd $user_name ..."
passwd $user_name

# put `<USER_NAME> ALL=(ALL) ALL` in /etc/sudoers
# echo "$user_name ALL=(ALL) ALL" >> /etc/sudoers
vim /etc/sudoers


