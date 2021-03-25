#!/bin/bash

#Setup of Linux machine
## Setup of Linux env
bash Miniconda3-latest-Linux-x86_64.sh 
sudo apt update
sudo apt install build-essential
# Install torch
pip install torch==1.7.1+cpu torchvision==0.8.2+cpu torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html
conda create --name dev-env python=3.7
conda activate dev-env
pip install scikit-learn numpy matplotlib pandas statsmodels tqdm
pip install jupyter jupyter_contrib_nbextensions
pip uninstall notebook
pip install notebook==5.7.8
jupyter contrib nbextension install --user

# Install docker on Ubuntu 20.04
## Install
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install     apt-transport-https     ca-certificates     curl     gnupg-agent     software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

## Adding current user to docker group
sudo addgroup docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world
