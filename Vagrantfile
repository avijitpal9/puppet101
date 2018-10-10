# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "centos/7"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  config.vm.define "master" do |master|
    master.vm.hostname = "puppetmaster"
    master.vm.network "private_network", ip: "192.168.100.10"
    master.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    master.vm.provision "shell", inline: <<-SHELL
      yum install -y http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
      yum install -y puppetserver ntp vim
      ntpdate 1.centos.pool.ntp.org
      systemctl start ntpd
      systemctl enable ntpd
      systemctl start puppetserver
      systemctl enable puppetserver
      sed -i 's/-Xms2g/-Xms1g/g;s/-Xmx2g/-Xmx1g/g' /etc/sysconfig/puppetserver
      sed -i '/127.0.0.1.*puppetmaster/d' /etc/hosts
      echo '192.168.100.10 puppetmaster.internal puppetmaster puppet' >>/etc/hosts
      echo '192.168.100.20 node1.internal node1'  >>/etc/hosts
      echo '192.168.100.30 node2.internal node2'  >>/etc/hosts
    SHELL
    master.vm.synced_folder "puppet-code/production", "/etc/puppetlabs/code/environments/production"
  end

  config.vm.define "node1" do |node1|
    node1.vm.hostname = "node1"
    node1.vm.network "private_network", ip: "192.168.100.20"
    node1.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
    end
    node1.vm.provision "shell", inline: <<-SHELL
      yum install -y http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
      yum install -y puppet-agent ntp
      ntpdate 1.centos.pool.ntp.org
      systemctl start ntpd
      systemctl enable ntpd
      echo '192.168.100.10 puppetmaster.internal puppetmaster puppet' >>/etc/hosts
      echo '192.168.100.20 node1.internal node1'  >>/etc/hosts
      echo '192.168.100.30 node2.internal node2'  >>/etc/hosts
    SHELL

  end

  config.vm.define "node2" do |node2|
    node2.vm.hostname = "node2"
    node2.vm.network "private_network", ip: "192.168.100.30"
    node2.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
    end
    node2.vm.provision "shell", inline: <<-SHELL
      yum install -y http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
      yum install -y puppet-agent
      ntpdate 1.centos.pool.ntp.org
      systemctl start ntpd
      systemctl enable ntpd
      echo '192.168.100.10 puppetmaster.internal puppetmaster puppet' >>/etc/hosts
      echo '192.168.100.20 node1.internal node1'  >>/etc/hosts
      echo '192.168.100.30 node2.internal node2'  >>/etc/hosts
    SHELL

  end


end
