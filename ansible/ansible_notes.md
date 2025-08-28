# SSH to the control node
```bash
vagrant ssh ansible-control
```

# SSH to client nodes
```bash
vagrant ssh client1
```
```bash
vagrant ssh client2
```

# Get SSH configs
```bash
vagrant ssh-config
```

# SSH to control node
```bash
ssh vagrant@192.168.56.10
```

# SSH to client nodes
```bash
ssh vagrant@192.168.56.11
```
```bash
ssh vagrant@192.168.56.12
```

**UN:** vagrant  
**PW:** vagrant  

# Ansible Commands
```bash
ansible -i inventory.yml -m ping client1
ansible-playbook -i inventory.yml create_users.yml --check # dry run
ansible-playbook -i inventory.yml create_users.yml --check --limit client1  # dry run for client1
ansible-playbook -i inventory.yml create_users.yml --limit client1 --tags groups # run only the tasks tagged with 'groups' for client1
```

How to install ansible roles ?  
```bash
# In the ansible-control provisioning section
if [ -f /home/vagrant/ansible/requirements.yaml ]; then
  echo "Installing Ansible roles from requirements.yaml..."
  sudo -u vagrant ansible-galaxy install -r /home/vagrant/ansible/requirements.yaml
fi
```

# Issue with host_vars not being picked up by ansible-playbook
This was due to host_vars dir being within root dir. Ansible do not read host_vars from root it needs to be inside inventory dir. You can not define host_vars in ansible.config as some of the chatbots suggest it does not work. Just make sure location is `\rootdir\inventory\host_vars`  

To test your all vars run:
```bash
ansible-inventory -i inventory/inventory.yml --list
```

To test vars for single host:
```bash
ansible -i inventory/inventory.yml client1 -m debug -a "var=hostvars['client1']"
```

# What is host_vars and group_vars ?
**Host_vars** defines variables for one specific host
```
host_vars/
  client1.yml   # applies only to client1
  client2.yml   # applies only to client2
```

**Group_vars** defines variables for group of hosts
```
group_vars/
  db.yml # applies to all hosts is [db] group defined in inventory.yml
  app.yml # applies to all hosts in [app] group defined in inventory.yml
```

# Remember
If vars exist in both then **group_vars will take precedence**.

# What is jinja template ?
A jinja tempalte is a text file that can include variables, loops and conditional logic which Ansible fills in dynamically at runtime.
Values can be read from host_vars or group_vars or playbook_vars. 