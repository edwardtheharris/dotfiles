---
abstract: Guide to the most difficult bare-metal Kubernetes cluster installation
    that I could think of.
authors:
    - Xander Harris
date: 2024-01-22
title: Bare-Metal Kubernetes for Masochists
---

```{admonition} OpenSSL
At some point, if we feel like it, it might be worth the time to set up
a proper CA on the LAN.

It sounds impossible, but you can, in fact, set up your own private
[Let's Encrypt](https://arstechnica.com/information-technology/2024/03/banish-oem-self-signed-certs-forever-and-roll-your-own-private-letsencrypt/)
```

## Goal

This project is intended to discover as many errors, faults, and problems as
possible in a Kubernetes cluster. To that end, a bare-metal Kubernetes cluster
will be built and run on a handful of [Stick PCs](https://a.co/d/d4H8iH7).

## Current Infrastructure

There are currently 5 of these available. One will be deployed as a router
to prevent my networking experiments interfering with my better half's
television time.

The remaining four will be deployed in two types. The first will be
Samba Active Directory Domain Controllers and Kubernetes worker nodes. There
will be two of these. The other two will be Kubernetes Control Planes and
worker nodes.

If this is successfully deployed, then I might try and think of something to do
with it. Until then, the answer to the question of why did you build this is
['Because it's there.'](http://scihi.org/george-mallory-mount-everest/)

```{epigraph}
Because it's there.

-- George Mallory, first white guy to summit Everest.
```

```{toctree}
etcd/index
dex/index
kube-apiserver/index
kube-controller-manager/index
```

## Process

This is the most difficult to implement setup that I could think of, if anyone
happens upon this tiny unremarkable corner of the internet who knows of a
more difficult implementation I'd love to hear about it.

1. Get ArchLinux installed on the stick PCs.
2. Bring up the router.
3. Make the {term}`AD` instances into a replicating pair of {term}`AD` {term}`DC`s.
4. Update the domain with all of the required DNS entries for {term}`AD`.
5. Validate the configuration and replication for the {term}`AD` {term}`DC`s.
6. Bring {term}`etcd` up on the Kubernetes Control Planes and produce an {term}`etcd` cluster with them.
7. Bring up the Control Plane instances and make sure they're clustered.
8. Finally, bring up the worker nodes and join them to the cluster.

### K8S Services by Host

```{list-table}
* - host
  - hostname
  - service
* - kcp01
  - kcp01.int.bh.loc
  - host
* -
  - etcd01.int.bh.loc
  - etcd key-value store
* -
  - kapi01.int.bh.loc
  - k8s api
* -
  - dm01.int.bh.loc
  - AD domain member
* - kcp02
  - kcp02.int.bh.loc
  - host
* -
  - etcd02.int.bh.loc
  - etcd key-value store
* -
  - kapi02.int.bh.loc
  - k8s api
* -
  - dm02.int.bh.loc
  - AD domain member
* - kw01
  - kw01.int.bh.loc
  - kubernetes worker / kubelet
* -
  - dc01.int.bh.loc
  - AD domain controller
* -
  - kdc01.int.bh.loc
  - kerberos
* -
  - ldap01.int.bh.loc
  - lightweight directory access
* - kw02
  - kw02.int.bh.loc
  - kubernetes worker / kubelet
* -
  - dc02.int.bh.loc
  - AD domain controller
* -
  - kdc02.int.bh.loc
  - kerberos
* -
  - ldap02.int.bh.loc
  - lightweight directory access
```

```{admonition} nerdctl
This may be helpful, but you'll need to look at the related package
page [here](https://aur.archlinux.org/packages/nerdctl-full-bin) to get
it working.
```
