#!/bin/bash
set -e

# Mise à jour du système
sudo apt-get update
sudo apt-get upgrade -y

# Supprimer l'ancienne version de Node.js (facultatif)
sudo apt-get install -y curl

# Installer une version plus récente de Node.js
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

# Installation des dépendances
sudo apt-get install -y python3 python3-pip libpq-dev python3-dev build-essential

#Installation de PM2
sudo npm install -g pm2

# Configuration de PostgreSQL
sudo apt-get install -y postgresql postgresql-contrib
sudo systemctl start postgresql
sudo systemctl enable postgresql

sudo -u postgres psql -c "CREATE DATABASE movies_db;"
sudo -u postgres psql -c "CREATE USER movieuser WITH PASSWORD 'moviepass';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE movies_db TO movieuser;"

# Installation des packages Python
pip3 install flask sqlalchemy psycopg2-binary python-dotenv Flask-SQLAlchemy

# # Copie des fichiers de l'application
sudo mkdir -p /opt/inventory-app
sudo cp -r /vagrant/srcs/inventory-app/* /opt/inventory-app/
sudo cp /vagrant/.env /opt/

# Installation des dépendances Python spécifiques à l'application
# pip3 install -r requirements.txt

# Démarrage de l'application avec PM2
sudo su - vagrant -c "pm2 start /opt/inventory-app/server.py --name inventory_app --interpreter python3"
