WORKERS = 3

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

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
  create_kube_host(config, "controller-0", "192.168.55.10", 2, 4096)

  # create workers
  for h in 0..WORKERS-1
    hostname = "worker-#{h}"
    ip = "192.168.55.2#{h}"
    create_kube_host(config, hostname, ip, 1, 2048)
  end
  
end
