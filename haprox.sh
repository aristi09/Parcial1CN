#!/bin/bash


echo "Inicializando LXD Container."
newgrp lxd
sudo snap install lxd --channel=4.0/stable
lxd init --auto 

echo "Creando contenedor llamado conthaproxy"
lxc launch ubuntu:18.04 conthaproxy
lxc exec conthaproxy -- apt-get update && apt-get upgrade -y

echo "Instalando haproxy"
lxc exec conthaproxy -- apt-get install haproxy -y
lxc exec conthaproxy -- systemctl enable haproxy

echo "Cambiando el mensaje de 503.http"
lxc file push /vagrant/haproxy.cfg conthaproxy/etc/haproxy/haproxy.cfg
lxc file push /vagrant/503.http conthaproxy/etc/haproxy/errors/
lxc exec conthaproxy -- systemctl start haproxy
echo "Añadiento puerto.."
sudo lxc config device add conthaproxy puertohap80 proxy listen=tcp:192.168.100.2:80 connect=tcp:127.0.0.1:80