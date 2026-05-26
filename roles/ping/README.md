---
abstract: Simple role to ping hosts on a network.
title: Ping readme
---

This role will send an Ansible ping to configured hosts.

## Requirements

Any network with a valid Ansible inventory will work.

## Role Variables

N/A

## Dependencies

N/A

## Example Playbook

There are no variables for this, just the list of hosts to ping in inventory.

```{code-block} yaml
:language: yaml

- hosts: servers
  roles:
      - { role: ping }
```

## License

Copyright (c) 2026 Xander Harris. All Rights Reserved.

### Author Information

```{sectionauthor} Xander Harris <xandertheharris@gmail.com>
```
