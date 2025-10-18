---
abstract: This role installs a few tweaks for development.
authors:
  - name: Xander Harris
    email: xandertheharris@gmail.com
date: 2025-07-10
title: Ansible Dev Role
---

## Dev Role

A role to enhance a workstation development by a developer.

### Dev Requirements

{term}`ArchLinux`, a developer, and an understanding of {term}`Ansible`.

### Dev Role Variables

None.

### Dev Dependencies

None.

### Dev Example Playbook

This is pretty simple, so. . .

```{code-block} yaml
:caption: sample playbook

- name: deploy dev role
  hosts: servers
  roles:
    - role: dev
      tags:
        - dev
```

### Dev License

Fuck you, pay me. Copyright (c) 2025, Xander Harris. All rights reserved.

### Dev Author Information

```{sectionauthor} Xander Harris <xandertheharris@gmail.com>
```
