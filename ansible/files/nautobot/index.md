---
abstract: Deploy a nautobot instance to an ArchLinux system.
authors: Xander Harris
date: 2024-01-26
title: Nautobot Installation
---

```{note}
This document is adapted from the original [installation guide](https://docs.nautobot.com/projects/core/en/stable/user-guide/administration/installation/)
which should be considered the source of truth for anyone that is installing
nautobot onto an ArchLinux or any other system.
```

## Requirements

To run [nautobot](https://github.com/nautobot/nautobot) you must provide
access to a working PostgreSQL, MySQL or MariaDB service. This guide
will use PostgreSQL, of which the version used by default appears to be 13 so
that will be the version used here.

You also need an instance of Redis, the default version appears to be 6 so that
will be the version used here.

If you want to enable metrics you will also need a Prometheus service available.

### PostgreSQL 13

This version is a little behind the latest release of Postgres, so to install
it we'll need to go to the
[AUR](https://aur.archlinux.org/packages?O=0&SeB=nd&K=postgresql13&outdated=&SB=p&SO=d&PP=50&submit=Go).

Since we've installed [yay](https://aur.archlinux.org/packages/yay) already
we can use it to install the required version of PostgreSQL 13.

```{code-block} shell
yay -Syu --noconfirm postgresql13 postgresql13-docs postgresql13-lib
```

```{sectionauthor} Xander Harris <xandertheharris@gmail.com>
```