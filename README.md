# Kuberenetes Kubeadm dev environment
This setup leverages on vagrant provisiner, [Ansible](https://www.vagrantup.com/docs/provisioning/ansible) to create a single master cluster for testing and development using the dynamic host setup and kubeadm to provision the cluster. Tested on MacOsX 11.6

### Prerequisites
* [Virtualbox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)

### Create Virtual Machines
Run `vagrant up` to bring up three virtual machines. Update the variable section of the Vagrantfile to change versions and number of workers

The hostnames and IP addresses of the machines are as follows:
```
kubemaster — 192.168.11.10

worker[1:N] – 192.168.2[1:N]
```

### Create kubernetes cluster
In the virtual environment created earlier, run
```
$ make vm
```
As soon as it is done, you can ssh into kubemaster to see the nodes and the pods in the cluster. They may take a while to get ready.
### Tear down cluster
```
$ make clean 
```
This will drain the nodes, make sure that they are empty before shutting them down and reset all kubeadm installed state.
```
$ make destroy
```
This will delete all VMs

## Reference
[Kubeclust](https://kosyfrances.github.io/kubernetes-cluster/) sets up a kubernetes 1.20.2 cluster on three VirtualBox virtual machines (one master and two workers) running Ubuntu 20.04 LTS using [kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm/).

[Sheldon's Vagrant CKS setup](https://github.com/pksheldon4/cks-cluster)