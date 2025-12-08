---
abstract: This roles installs a Kubernetes Control Plane Node.
authors: Xander Harris
date: 2024-03-01
title: Kubernetes Control Plane
---

Presently only a single Control Plane cluster is supported, but support for
high availability clusters will hopefully be available soon.

[HA Clusters with Kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/)
is helped with use of the tool
[kube-vip](https://kube-vip.io/docs/installation/static/).

More information about the process for HA setup is available
[here](https://github.com/kubernetes/kubeadm/blob/main/docs/ha-considerations.md#kube-vip).

A handy tool for switching k8s contexts is called
[kubie](https://github.com/sbstp/kubie).
