# Root folder for your Ansible project
$projectRoot = "C:\Users\JP4583478\Documents\VagrantProjects\Ansible\ansible"

# Create main directories
$dirs = @(
    "$projectRoot\inventory",
    "$projectRoot\playbooks",
    "$projectRoot\roles",
    "$projectRoot\host_vars\client1",
    "$projectRoot\host_vars\client2"
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
        $filePath = "$projectRoot\host_vars\$client\$file"
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
