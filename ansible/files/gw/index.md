---
abstract: This document describes the process of creating a simple
    router out of a minimal computer running ArchLinux.
authors: Xander Harris
date: 2024-01-26
title: Router Configuration
---

```{note}
This guide is adapted from
[the official guide](https://wiki.archlinux.org/title/Router) on the ArchLinux
wiki. The official guide should be considered the source of truth as this one is
unlikely to be updated.
```

```{rubric} 2024-01-21
```

## Purpose

After some weeks of intermittently pissing off my wife by cutting off her
internet access by screwing up the routing tables in our main network it
has become apparent that it will be necessary to set up a DMZ behind a
simple Linux router.

This router will be configured using the ArchLinux {term}`Router` wiki
page in combination with the ArchLinux
[installation guide](https://wiki.archlinux.org/title/Installation_guide).

## Acquisition

The router will run on a [stick pc](https://a.co/d/dUHexZE) acquired from
Amazon, to be delivered early on 2024-01-22.

```{admonition} int0, ext0
Throughout the article, int0 and ext0 are used as names for the network
interfaces for convenience.
```

## NIC Configs

According to the
[guide](https://wiki.archlinux.org/title/Router#IP_configuration) we'll
have to use either {term}`systemd`-networkd or {term}`netctl`
configure the ip addresses for this machine. Instead, we'll be using
NetworkManager because it is the simplest to manage.

```{admonition} Warning
Do not enable concurrent, conflicting network services.
Use `systemctl --type=service` to ensure that no other
network service is running before enabling a netctl
profile/service.
```

That is, because we're already using NetworkManager, there is no need
to configure and install either {term}`netctl` or the {term}`systemd`
service.

### Configure the interface names

This will be done with some `udev` rules added to `/etc/udev/rules.d`.
Copy the file shown below to the path in the caption but replace
the MAC addresses with those of your interfaces then reboot your system.

```{literalinclude} 10-network.rules
:caption: /etc/udev/rules.d/10-network.rules
:language: properties
```

## Configure NetworkManager

Since we're using NetworkManager, there is a convenient curses
interface with which to configure the interfaces. For our setup
we need to make sure the `ext0` interface is configured to use
the IP `192.168.1.20/32` and the `int0` interface is configured
to use the CIDR `172.16.0.1/24`.

```{code-block} shell
:caption: edit the connections for NetworkManager

sudo nmtui
sudo systemctl restart NetworkManager
ip addr
```

When you run the `ip` command you should see something similar
to the output below if you edited things correctly.

```{code-blocK} shell
:caption: ip addr output

1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: int0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
    inet 172.16.0.1/16 brd 172.16.255.255 scope global noprefixroute int0
    ...
3: ext0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.20/32 scope global noprefixroute ext0
       valid_lft forever preferred_lft forever
```

### Configure a firewall

For a firewall we'll use {term}`crowdsec`. We'll configure it
using the process below.

1. Install the package.

    ```{code-block} shell
    yay -S crowdsec
    ```

2. Install the bouncers.

    ```{code-block} shell
    yay -S crowdsec-firewall-bouncer-nftables
    ```

    ```{note}
    Based on a reading of the first three paragraphs or so
    of [this](https://linuxhandbook.com/iptables-vs-nftables/)
    article, we're going to use `nftables`.
    ```

3. Enroll the gateway machine in Crowdsec.

    ```{code-block} shell
    sudo cscli console enroll 0000000000000000000000000
    ```

4. Restart the {term}`crowdsec` service.

    ```{code-block} shell
    sudo systemctl restart crowdsec
    ```

5. Open the [console](https://app.crowdsec.net) and follow any
   instructions there.

## Enable packet forwarding

This is done manually by using {term}`sysctl` as described below.
More information is available
[here](https://wiki.archlinux.org/title/Internet_sharing#Enable_packet_forwarding).

```{admonition} Firewall
Do not enable packet forwarding without first configuring
a firewall, be it {term}`crowdsec` or some other option.
```

### configure sysctl

1. Check the current settings.

    More information is available [here](https://docs.kernel.org/networking/ip-sysctl.html)

    ```{code-block} shell
    sysctl -a | grep forward
    ```

2. Add the required configuration file to the sysctl conf directory.

    ```{code-block} properties
    :caption: /etc/sysctl.d/30-ipforward.conf

    net.ipv4.ip_forward = 1
    net.ipv4.conf.all.forwarding = 1
    net.ipv6.conf.all.forwarding = 1
    ```

## {term}`UFW`

If you haven't spent the last twenty years mucking about with iptables rules,
you may find it helpful to install `nftables` and {term}`ufw` in order to
configure they NAT required for the router to work.

The information in the following [gist](https://gist.github.com/kimus/9315140)
is very helpful.

It is reproduced here just in case someone decides to remove it.

### {term}`UFW` [Gist](https://gist.github.com/kimus/9315140)

> I use Ubuntu’s Uncomplicated firewall because it is available on Ubuntu and
> it's very simple.
>
> #### Install UFW
>
> If ufw is not installed by default be sure to install it first.
>
> ```{code-block} shell
> sudo apt-get install ufw
> ```
>
> #### NAT
>
> If you needed ufw to NAT the connections from the external interface to the
> internal the solution is pretty straight forward. In the file
> {file}`/etc/default/ufw` change the parameter `DEFAULT_FORWARD_POLICY`
>
> ```{code-block} shell
> DEFAULT_FORWARD_POLICY="ACCEPT"
> ```
>
> Also configure {file}`/etc/ufw/sysctl.conf` to allow ipv4 forwarding
> (the parameters is commented out by default). Uncomment for ipv6 if you want.
>
> ```{code-block} properties
> net.ipv4.ip_forward=1
> #net/ipv6/conf/default/forwarding=1
> #net/ipv6/conf/all/forwarding=1
> ```
>
> The final step is to add NAT to ufw’s configuration. Add the following to
> {file}`/etc/ufw/before.rules` just before the filter rules.
>
> ```{code-block} s
> # NAT table rules
> *nat
> :POSTROUTING ACCEPT [0:0]
>
> # Forward traffic through eth0 - Change to match you out-interface
> -A POSTROUTING -s 192.168.1.0/24 -o eth0 -j MASQUERADE
>
> # don't delete the 'COMMIT' line or these nat table rules won't
> # be processed
> COMMIT
> ```
>
> Now enable the changes by restarting ufw.
>
> ```{code-block} shell
> sudo ufw disable && sudo ufw enable
> ```
>
> #### FORWARD
>
> For port forwarding just do something like this.
>
> ```{code-block} s
> # NAT table rules
> *nat
> :PREROUTING ACCEPT [0:0]
> :POSTROUTING ACCEPT [0:0]
>
> # Port Forwardings
> -A PREROUTING -i eth0 -p tcp --dport 22 -j DNAT --to-destination 192.168.1.10
>
> # Forward traffic through eth0 - Change to match you out-interface
> -A POSTROUTING -s 192.168.1.0/24 -o eth0 -j MASQUERADE
>
> # don't delete the 'COMMIT' line or these nat table rules won't
> # be processed
> COMMIT
> ```

## Enable Wireless AP

1. Install the `hostapd` package.

    ```{code-block} shell
    yay -S hostapd
    ```

2. Configure the `hostapd` to suit your needs.

    ```{code-block} ini
    :caption: /etc/hostapd/hostapd.conf

    interface=wlan0_ap
    bridge=br0

    # SSID to be used in IEEE 802.11 management frames
    ssid=charlesproteussteinmetz
    # Driver interface type (hostap/wired/none/nl80211/bsd)
    driver=nl80211
    # Country code (ISO/IEC 3166-1)
    country_code=US

    # Operation mode (a = IEEE 802.11a (5 GHz), b = IEEE 802.11b (2.4 GHz)
    hw_mode=a
    # Channel number
    channel=7
    # Maximum number of stations allowed
    max_num_sta=5

    # Bit field: bit0 = WPA, bit1 = WPA2
    wpa=2
    # Bit field: 1=wpa, 2=wep, 3=both
    auth_algs=1

    # Set of accepted cipher suites; disabling insecure TKIP
    wpa_pairwise=
    # Set of accepted key management algorithms
    wpa_key_mgmt=
    wpa_passphrase=

    # hostapd event logger configuration
    logger_stdout=-1
    logger_stdout_level=2

    ## Enable 802.11n support
    #ieee80211n=1
    ## Enable 802.11ac support
    #ieee80211ac=1
    ## Enable 802.11ax support
    #ieee80211ax=1
    ## QoS support
    #wmm_enabled=1
    ## Use "iw list" to show device capabilities and modify ht_capab and vht_capab accordingly
    #ht_capab=[HT40+][SHORT-GI-40][TX-STBC][RX-STBC1][DSSS_CCK-40]
    #vht_capab=[RXLDPC][SHORT-GI-80][TX-STBC-2BY1][RX-STBC-1]
    ```

3. Start and enable the `hostapd` daemon.
