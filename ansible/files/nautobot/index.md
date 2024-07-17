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
yay -Syu --noconfirm postgresql13 postgresql13-docs postgresql13-lib python python-pip python-psycopg2
```

#### Initialize the data directory

If your data directory is empty, you'll need to initialize.

```{code-block} shell
sudo -u postgres -c "initdb --locale en_US.UTF-8 -D '/var/lib/postgres/data'"
```

#### Start and Enable PostgreSQL

```{code-block} shell
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

### Redis 6

This is also a little behind the latest version, so we'll need to go
to the [AUR](https://aur.archlinux.org/packages/redis6) for the package.

```{code-block} shell
yay -Syu --noconfirm redis6
```

#### Link odd files

Not sure why the files are named this way, but some links will fix them.

```{code-block} shell
ln -sfv /usr/bin/redis\{6\}-benchmark /usr/bin/redis6-benchmark
ln -sfv /usr/bin/redis\{6\}-cli /usr/bin/redis6-cli
ln -sfv /usr/bin/redis\{6\}-server /usr/bin/redis6-server
ln -sfv /usr/bin/redis\{6\}-server /usr/bin/redis-server
```

#### Start and enable Redis

```{code-block} shell
sudo systemctl start redis6
sudo systemctl enable redis6
```

## Install nautobot

The first step is to clone the GitHub repository into the new `NAUTOBOT_ROOT`,
for our installation it will be {file}`/opt/nautobot`.

```{code-block} shell
sudo git clone https://github.com/nautobot/nautobot.git /opt/nautobot
```

### User, group, ownership

We'll need a user and group to own the directory, so let's create them.

```{code-block} shell
sudo groupadd nautobot
sudo useradd -s /bin/bash -m -d /opt/nautobot -g nautobot nautobot
echo "export NAUTOBOT_ROOT=/opt/nautobot" > /etc/profile.d/nautobot.sh
```

Now we need to make sure the root is owned by the `nautobot` user.

```{code-block} shell
sudo chown -Rv nautobot:nautobot /opt/nautobot
```

### Init the server

```{code-block} shell
sudo -u nautobot nautobot-server init
sudo -u nautobot cp /opt/nautobot/.nautobot/nautobot_config.py /opt/nautobot/nautobot_config.py
```

```{sectionauthor} Xander Harris <xandertheharris@gmail.com>
```
