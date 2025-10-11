---
abstract: This role provides a basic configuration for ArchLinux.
authors:
  - name: Xander Harris
    email: xandertheharris@gmail.com
date: 205-07-10
title: ArchLinux Ansible Role
---

Add some missing packages and configure a thing or two.

## ArchLinux Ansible Role Requirements

Package installation is handled with [yay-bin](https://aur.archlinux.org/yay-bin).

## ArchLinux Ansible Role Variables

| variable | description                   | default |
| -------- | ----------------------------- | ------- |
| packages | A list of packages to install | []      |

## ArchLinux Ansible Role Dependencies

None

## ArchLinux Ansible Role Example Playbook

```{code-block} yaml
    - hosts: servers
      roles:
         - role: arch
           vars:
              packages:
                - plasma
```

## ArchLinux Ansible Role License

Fuck you, pay me. Copyright (c) 2025, Xander Harris. All rights reserved.

## ArchLinux Ansible Role Author Information

```{sectionauthor} Xander Harris <xandertheharris@gmail.com>

```
