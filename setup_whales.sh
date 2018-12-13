#!/usr/bin/env bash

# Setup Swap
echo "Setting up swap..."
sudo dd if=/dev/zero of=/swapfile bs=1G count=4
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile swap swap defaults 0 0' | sudo tee -a /etc/fstab

echo -e "Finished!\n"
# Install Docker

echo "Installing Docker..."
sudo apt-get update
sudo apt-get install \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install docker-ce
echo -e "Finished!\n"

# Install Nginx

sudo apt install nginx
sudo ufw allow 'Nginx Full'
sudo systemctl restart nginx

# Install Certbot (can't auto secure until nginx is setup)

sudo add-apt-repository ppa:certbot/certbot
sudo apt install python-certbot-nginx

# Install Node.js

curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs build-essential

# Install PM2 Process Manager

sudo npm install pm2@latest -g

# Add Base Aliases

echo "alias ..='cd ..'"
echo "alias ...='cd ../..'"
echo "alias ....='cd ../../..'"
