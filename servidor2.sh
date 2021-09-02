#!/bin/bash


echo "Instalando LXD Container"
sudo snap install lxd --channel=4.0/stable
newgrp lxd
lxd init --auto

echo "Creando contenedor llamado contserv2" 
lxc launch ubuntu:18.04 contserv2
lxc exec contserv2 -- apt-get update && apt-get upgrade -y

echo "Instalando apache para contserv2"
lxc exec contserv2 -- apt-get install apache2 -y

echo "Activacion apache para contserv2"
lxc exec contserv2 -- systemctl enable apache2
lxc file push /vagrant/index2.html contserv2/var/www/html/index.html
lxc exec contserv2 -- systemctl restart apache2

echo "Añadiendo puerto.."
sudo lxc config device add contserv2 s2puerto80 proxy listen=tcp:192.168.100.4:80 connect=tcp:127.0.0.1:80


sudo snap install lxd --channel=4.0/stable
newgrp lxd
lxd init --auto

echo "Creando contenedor para backup del Servidor2" 
lxc launch ubuntu:18.04 backupserv2
lxc exec backupserv2 -- apt-get update && apt-get upgrade -y

echo "Instalando Apache"
lxc exec backupserv2 -- apt-get install apache2 -y

echo "Activacion apache para backupserv2"
lxc exec backupserv2 -- systemctl enable apache2
lxc file push /vagrant/backup2.html backupserv2/var/www/html/index.html
lxc exec backupserv2 -- systemctl restart apache2

echo "Añadiendo puerto.."
sudo lxc config device add backupserv2 back22280 proxy listen=tcp:192.168.100.4:2280 connect=tcp:127.0.0.1:80