# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
config.vm.define :haproxyUbuntu do |haproxyUbuntu|
haproxyUbuntu.vm.box = "bento/ubuntu-20.04"
haproxyUbuntu.vm.network :private_network, ip: "192.168.100.2"
haproxyUbuntu.vm.provision "shell", path: "haprox.sh"
haproxyUbuntu.vm.hostname = "haproxyUbuntu"
end
config.vm.define :servidor1 do |servidor1|
servidor1.vm.box = "bento/ubuntu-20.04"
servidor1.vm.network :private_network, ip: "192.168.100.3"
servidor1.vm.provision "shell", path: "servidor1.sh"
servidor1.vm.hostname = "servidor1"
end
config.vm.define :servidor2 do |servidor2|
servidor2.vm.box = "bento/ubuntu-20.04"
servidor2.vm.network :private_network, ip: "192.168.100.4"
servidor2.vm.provision "shell", path: "servidor2.sh"
servidor2.vm.hostname = "servidor2"
end
end
