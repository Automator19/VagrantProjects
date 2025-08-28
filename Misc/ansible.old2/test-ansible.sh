#!/bin/bash
cd /vagrant/ansible
echo "Testing Ansible connectivity..."
ansible all_clients -m ping
