# -*- mode: ruby -*-
# # vi: set ft=ruby :

WORKERS = 2

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.boot_timeout = 60

  def create_kube_host(config, hostname, ip, cpus, memory)
    config.vm.define hostname do |host|
      host.vm.hostname = hostname
      host.vm.network "private_network", ip: ip
      host.vm.provision "shell", path: "provision.sh"
      host.vm.provider :virtualbox do |vb|
        vb.cpus = cpus
        vb.memory = memory
      end
    end
  end

  # create controller
  create_kube_host(config, "controller-0", "192.168.55.10", 2, 2048)

  # create workers
  for h in 0..WORKERS-1
    hostname = "worker-#{h}"
    ip = "192.168.55.2#{h}"
    create_kube_host(config, hostname, ip, 1, 2048)
  end
  
end
