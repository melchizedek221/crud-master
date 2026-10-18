#!/bin/bash
set -e

# Mise à jour du système
sudo apt-get update
sudo apt-get upgrade -y

# Supprimer l'ancienne version de Node.js (facultatif)
sudo apt-get install -y curl
# sudo apt-get remove -y nodejs

# Installer une version plus récente de Node.js
# curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash - this is deprecated, we will use the following instead
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Installation des dépendances
sudo apt-get install -y python3 python3-pip libpq-dev python3-dev build-essential

# Installer PM2
sudo npm install -g pm2

# Installation des packages Python
sudo pip3 install flask requests pika python-dotenv
sudo pip3 install flask-restx
sudo pip3 install importlib-metadata

# Copie des fichiers de l'application
sudo mkdir -p /opt/api-gateway
sudo cp -r /vagrant/srcs/api-gateway/* /opt/api-gateway/
sudo cp /vagrant/.env /opt/api-gateway/.env
# pip3 install flask sqlalchemy psycopg2-binary pika pyyaml python-dotenv

# Installation des dépendances Python spécifiques à l'application
pip3 install -r /opt/api-gateway/requirements.txt

sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install -y python3.8

# Set Python 3.8 as default
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
sudo update-alternatives --set python3 /usr/bin/python3.8

sudo apt-get install -y python3-pip libpq-dev python3-dev build-essential
sudo pip3 install flask requests pika python-dotenv flask-restx importlib-metadata

# Démarrage de l'application avec PM2
sudo su - vagrant -c "pm2 start /opt/api-gateway/server.py --name api_gateway --interpreter python3"