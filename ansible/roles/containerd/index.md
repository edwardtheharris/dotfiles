---
abstract: This role prepares containerd for use with a Kubernetes cluster.
authors: Xander Harris
date: 2024-03-01
title: ContainerD Setup
---

This role is a pre-requisite for running the `kcp` or `k8s` roles. It ensures
that `containerd` is installed then copies a workable `cgroup` configuration
and prepares the networking for Kubernetes.
