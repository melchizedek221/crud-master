#!/bin/bash
set -e

# Mise à jour du système et installation des dépendances
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y curl python3 python3-pip postgresql rabbitmq-server libpq-dev python3-dev

# Installation de Node.js
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs

# Installation globale de PM2
sudo npm install -g pm2

# Configuration de PostgreSQL
sudo -u postgres psql -c "CREATE DATABASE billing_db;"
sudo -u postgres psql -c "CREATE USER billinguser WITH PASSWORD 'billingpass';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE billing_db TO billinguser;"

# Configuration de RabbitMQ
sudo rabbitmq-plugins enable rabbitmq_management
sudo systemctl start rabbitmq-server
sudo systemctl enable rabbitmq-server
sudo rabbitmqctl add_user myuser mypassword
sudo rabbitmqctl set_user_tags myuser administrator
sudo rabbitmqctl set_permissions -p / myuser ".*" ".*" ".*"

# Installation des packages Python
pip3 install flask sqlalchemy pika python-dotenv Flask-SQLAlchemy psycopg2

# Copie des fichiers de l'application
sudo mkdir -p /opt/billing-app
sudo cp -r /vagrant/srcs/billing-app/* /opt/billing-app/
sudo cp /vagrant/.env /opt/


# Start the application with PM2 as the vagrant user
sudo su - vagrant -c "pm2 start /opt/billing-app/server.py --name billing_app --interpreter python3"