---
abstract: Install guide to create a fully-functional ArchLinux LiveUSB.
authors:
    - Xander Harris
date: 2024-01-20
title: ArchLinux Install to USB
---

## Guide

The idea here is to provide a guide for installing a fully functional
ArchLinux installation onto a USB key.

### To a LiveUSB

```sh
sudo pacstrap -K /mnt base linux linux-firmware base-devel btrfs-progs vim \
    man-db man-pages texinfo git networkmanager iwd sudo shadow
```

You must run this with `sudo`, and not as `root` because the `root` user of
an existing ArchLinux system will have its own keyring for `pacman` and will
fail to run the command because of that.

## Create an fstab

```sh
sudo su -
genfstab -U /mnt >> /mnt/etc/fstab
```

- [Archiso](https://wiki.archlinux.org/title/Archiso)
