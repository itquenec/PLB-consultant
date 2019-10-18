# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|

  config.vm.provision "shell", path: "bootstrap.sh"

  # Docker Master Server
  config.vm.define "ansiblemaster" do |ansiblemaster|
    ansiblemaster.vm.box = "centos/7"
    ansiblemaster.vm.hostname = "ansiblemaster.plb.form"
    ansiblemaster.vm.network "private_network", ip: "172.42.42.100"
    ansiblemaster.vm.provider "virtualbox" do |v|
      v.name = "ansiblemaster"
      v.memory = 2048
      v.cpus = 2
    end
    ansiblemaster.vm.provision "shell", path: "bootstrap.sh"
  end

  NodeCount = 2

  # Docker Worker Nodes
  (1..NodeCount).each do |i|
    config.vm.define "ansibleworker#{i}" do |workernode|
      workernode.vm.box = "centos/7"
      workernode.vm.hostname = "ansibleworker#{i}.plb.form"
      workernode.vm.network "private_network", ip: "172.42.42.10#{i}"
      workernode.vm.provider "virtualbox" do |v|
        v.name = "ansibleworker#{i}"
        v.memory = 1024
        v.cpus = 1
      end
      workernode.vm.provision "shell", path: "bootstrap.sh"
    end
  end

end
