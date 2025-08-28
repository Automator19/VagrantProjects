1. Before executing `vagrant up`, ensure that **Ansible** dir is created.  
   - This is required so Vagrant can mount the dir to `/home/vagrant/Ansible`

2. After Vagrant setup is completed:  
   - Log on to **ansible-control** node  
   - Browse to `/home/vagrant`  
   - Run:
     ```bash
     ./setup-ssh-keys.sh
     ```
     to import private keys into `.ssh` dir

3. Install collection with this command:
   ```bash
   ansible-galaxy collection install -r requirements.yml
