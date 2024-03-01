---
abstract: >
    This is a guide to setting up an AD DC on ArchLinux with Samba.
authors:
    - Xander Harris
date: 2024-01-20
title: ArchLinux AD DC Setup Guide
---

## Samba {term}`AD`

The intent of the {term}`AD` {term}`DC`s is to provide an authentication
backend for at least two etcd servers that will provide a key-value store for a
bare-metal Kubernetes cluster for which the `AD` `DC`s will act as
worker nodes.

```{toctree}
ca/index
samba/index
```

- [Active Directory Naming](https://wiki.samba.org/index.php/Active_Directory_Naming_FAQ)
- [Active Directory DC](https://wiki.archlinux.org/title/Samba/Active_Directory_domain_controller)
- [Active Directory Integration](https://wiki.archlinux.org/title/Active_Directory_integration)
