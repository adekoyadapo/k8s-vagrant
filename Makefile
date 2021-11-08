infra: vm

vm:
	vagrant up

clean:
	ansible-playbook playbook.deletecluster.yml -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory

provision:
	vagrant provision --provision-with ansible	

destroy:
	vagrant destroy -g -f
