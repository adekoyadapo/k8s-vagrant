# -*- mode: ruby -*-
# vi: set ft=ruby :

VM_ID = "vagrant"
NUM_WORKER_NODES = 2
IP_NW = "192.168.11."
IP_START=20
K8S_VERSION = "1.21.6"
VAGRANTFILE_API_VERSION = "2"
DOCKER_VERSION = "20.10.7-0ubuntu1~20.04.2"
CONTAINERD_VERSION = "1.5.5-0ubuntu3~20.04.1"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provision "shell", path: "provision.sh"
  config.vm.provider :virtualbox do |v|
    v.memory = 2048
    v.cpus = 2
  end
  config.vm.define "#{VM_ID}-master" do |kubemaster|
    kubemaster.vm.box = "ubuntu/focal64"
    kubemaster.vm.hostname = "#{VM_ID}-master"
    kubemaster.vm.network :private_network, bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.11.10"
  end
  (1..NUM_WORKER_NODES).each do |worker_id|
    config.vm.define "#{VM_ID}-worker-#{worker_id}" do |worker|
      worker.vm.box = "ubuntu/focal64"
      worker.vm.hostname = "#{VM_ID}-worker-#{worker_id}"
      worker.vm.network :private_network, bridge: "en0: Wi-Fi (AirPort)", ip: IP_NW + "#{IP_START + worker_id}" 
      # only execute once the ansible provisioner,
      # when all the machines are up and ready.
      if worker_id == NUM_WORKER_NODES
        worker.vm.provision :ansible do |ansible|
          # disable default limit to connect to all the machines
          # execute playbook1 on all hosts

          ansible.limit = "all"
          ansible.groups = {
            "master" => ["#{VM_ID}-master"],
            "master:vars" => {"K8S_VERSION" => "#{K8S_VERSION}",
            "DOCKER_VERSION" => "#{DOCKER_VERSION}",
            "CONTAINERD_VERSION" => "#{CONTAINERD_VERSION}"
            },
            "worker" => ["#{VM_ID}-worker-[1:#{NUM_WORKER_NODES}]"],
            "worker:vars" => {"K8S_VERSION" => "#{K8S_VERSION}",
            "DOCKER_VERSION" => "#{DOCKER_VERSION}",
            "CONTAINERD_VERSION" => "#{CONTAINERD_VERSION}"
            }
          }
          ansible.playbook = "playbook.kubecluster.yml"
        end
      end
    end
  end
end
