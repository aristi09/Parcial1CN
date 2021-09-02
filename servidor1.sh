#!/bin/bash


echo "Instalando LXD Container"
sudo snap install lxd --channel=4.0/stable
newgrp lxd
lxd init --auto 
echo "Creando contenedor llamado contserv1"
lxc launch ubuntu:18.04 contserv1
lxc exec contserv1 -- apt-get update && apt-get upgrade -y
lxc exec contserv1 -- apt-get install apache2 -y
lxc exec contserv1 -- systemctl enable apache2
lxc file push /vagrant/index1.html contserv1/var/www/html/index.html
lxc exec contserv1 -- systemctl restart apache2
echo "Añadiendo puerto.."
sudo lxc config device add contserv1 s1puerto80 proxy listen=tcp:192.168.100.3:80 connect=tcp:127.0.0.1:80
sudo snap install lxd --channel=4.0/stable
newgrp lxd
lxd init --auto
echo "Creando contenedor para backup del Servidor1"
lxc launch ubuntu:18.04 backupserv1
lxc exec backupserv1 -- apt-get update && apt-get upgrade -y
lxc exec backupserv1 -- apt-get install apache2 -y
echo "Activacion apache para backupserv1"
lxc exec backupserv1 -- systemctl enable apache2
lxc file push /vagrant/backup1.html backupserv1/var/www/html/index.html
lxc exec backupserv1 -- systemctl restart apache2
echo "Añadiendo puerto.."
sudo lxc config device add backupserv1 back12280 proxy listen=tcp:192.168.100.3:2280 connect=tcp:127.0.0.1:80