# Root folder for your Ansible project
$projectRoot = "C:\Users\JP4583478\Documents\VagrantProjects\Ansible\ansible"

# Create main directories
$dirs = @(
    "$projectRoot\inventory",
    "$projectRoot\playbooks",
    "$projectRoot\roles",
    "$projectRoot\inventory\host_vars\client1",
    "$projectRoot\inventory\host_vars\client2"
)

foreach ($dir in $dirs) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "Created directory: $dir"
    }
}

# Create sample roles
$roles = @(
    "lvm_setup",
    "extra_dirs",
    "manage_groups",
    "manage_users",
    "sudoers",
    "sysctl",
    "limits",
    "packages"
)

foreach ($role in $roles) {
    $rolePath = "$projectRoot\roles\$role\tasks"
    if (-not (Test-Path $rolePath)) {
        New-Item -ItemType Directory -Path $rolePath -Force | Out-Null
        Write-Host "Created role tasks directory: $rolePath"

        # create empty main.yml file
        New-Item -ItemType File -Path "$rolePath\main.yml" -Force | Out-Null
        Write-Host "Created file: $rolePath\main.yml"
    }
}

# Create sample host_vars YAML files for client1 and client2
$clients = @("client1", "client2")
$hostVarsFiles = @(
    "lvm.yml",
    "dirs.yml",
    "groups.yml",
    "users.yml",
    "sudoers.yml",
    "sysctl.yml",
    "limits.yml",
    "packages.yml"
)

foreach ($client in $clients) {
    foreach ($file in $hostVarsFiles) {
        $filePath = "$projectRoot\inventory\host_vars\$client\$file"
        if (-not (Test-Path $filePath)) {
            "" | Out-File -FilePath $filePath -Encoding UTF8
            Write-Host "Created host_vars file: $filePath"
        }
    }
}

# Create sample playbook
$playbookPath = "$projectRoot\playbooks\setup.yml"
if (-not (Test-Path $playbookPath)) {
    @"
---
- hosts: all
  become: yes
  roles:
    - lvm_setup
    - extra_dirs
    - manage_groups
    - manage_users
    - sudoers
    - sysctl
    - limits
    - packages
"@ | Out-File -FilePath $playbookPath -Encoding UTF8
    Write-Host "Created playbook: $playbookPath"
}

Write-Host "`nAnsible project structure created successfully at $projectRoot"


# Create ansible.cfg
$ansibleCfg = "$projectRoot\ansible.cfg"
if (-not (Test-Path $ansibleCfg)) {
    @"
[defaults]
inventory = 
roles_path = 
host_key_checking = False
retry_files_enabled = False
"@ | Out-File -FilePath $ansibleCfg -Encoding UTF8
    Write-Host "Created ansible.cfg"
}

# Create requirements.yml
$reqFile = "$projectRoot\requirements.yml"
if (-not (Test-Path $reqFile)) {
    @"
---
roles:
  - name: 

collections:
  - name: 
"@ | Out-File -FilePath $reqFile -Encoding UTF8
    Write-Host "Created requirements.yml"
}

# create inventory file
$inventoryFile = "$projectRoot\inventory\inventory.yml"
if (-not (Test-Path $inventoryFile)) {
    @"
---
all:
  hosts:
    client1:
      ansible_host: 
      ansible_user: 
      ansible_ssh_private_key_file: 
    client2:
      ansible_host: 
      ansible_user: 
      ansible_ssh_private_key_file: 
  children:
    db_servers:
      hosts:
        client1:
    app_servers:
      hosts:
        client2:
"@ | Out-File -FilePath $inventoryFile -Encoding UTF8
    Write-Host "Created inventory file: $inventoryFile"

}