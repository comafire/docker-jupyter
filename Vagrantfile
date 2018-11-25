# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.configure("2") do |config|

  config.vm.define "v01" do |host|
    host.vm.box = "ubuntu/xenial64"
    host.vm.hostname = "v01"
    host.vm.network "public_network", ip: "192.168.0.70"
    #host.vm.network "private_network", ip: "10.0.1.1"
    host.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.cpus = 4
      vb.memory = "8192"
    end
    host.disksize.size = '128GB'
    host.vm.synced_folder "./", "/home/vagrant/docker-jupyter", owner: "vagrant", group: "vagrant"
  end

end
