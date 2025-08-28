[![tests](https://github.com/boutetnico/ansible-role-users/workflows/Test%20ansible%20role/badge.svg)](https://github.com/boutetnico/ansible-role-users/actions?query=workflow%3A%22Test+ansible+role%22)
[![Ansible Galaxy](https://img.shields.io/badge/galaxy-boutetnico.users-blue.svg)](https://galaxy.ansible.com/boutetnico/users)

ansible-role-users
==================

This role manages users and groups.

Requirements
------------

Ansible 2.10 or newer.

Supported Platforms
-------------------

- [Debian - 11 (Bullseye)](https://wiki.debian.org/DebianBullseye)
- [Debian - 12 (Bookworm)](https://wiki.debian.org/DebianBookworm)
- [Ubuntu - 22.04 (Jammy Jellyfish)](http://releases.ubuntu.com/22.04/)
- [Ubuntu - 24.04 (Noble Numbat)](http://releases.ubuntu.com/24.04/)

Role Variables
--------------

| Variable                | Required | Default              | Choices | Comments                                  |
|-------------------------|----------|----------------------|---------|-------------------------------------------|
| users_groups            | yes      | `[]`                 | list    |                                           |
| users_users             | yes      | `[]`                 | list    |                                           |

Dependencies
------------

None

Example Playbook
----------------

    - hosts: all
      roles:
        - ansible-role-users

          users_groups:
            - name: group1
              gid: 33
              system: true

          users_users:
            - name: user1
              group: group1
              create_home: true
              home: /home/user1

Testing
-------

    molecule test

License
-------

MIT

Author Information
------------------

[@boutetnico](https://github.com/boutetnico)
