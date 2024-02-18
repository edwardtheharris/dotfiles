---
abstract: >
    This is a guide to the {file}`smb.conf` configuration file.
authors: Xander Harris
date: 2024-01-20
title: Samba Configuration Guide
---

```{rubric} 2024-01-27
```

---

The default {file}`smb.conf` file is available online
[here](path:/ansible/files/ad/samba/conf/smb.conf.default).

You'll need this to use the `smbclient` utility.

## Connecting to Shares

```{note}
smbclient requires a {file}`/etc/samba/smb.conf` file, which you
can create as an empty file using the touch utility.
After installing cifs-utils or smbclient, load the cifs kernel module or
reboot to prevent mount fails.
```

This is the tool that allows mounting samba shares and interacting with
available resources.

## Primary {term}`AD` {term}`DC` Config

## Secondary {term}`AD` {term}`DC` Config

## Joining the domain

You may find [this guide](http://tinyurl.com/y5rjn946)
helpful for joining from MacOS systems.
