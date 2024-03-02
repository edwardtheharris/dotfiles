---
title: kube-apiserver configuration
---

This folder contains the service and configuration files needed to get
a kube-apiserver up and running.

<!-- markdownlint-disable -->
```{code-block} shell
kube-apiserver --bind-address=0.0.0.0 --enable-bootstrap-token-auth --etcd-cafile=/etc/ssl/certs/dc01.bundle.crt --etcd-certfile=/etc/etcd/pki/etcd.crt --etcd-keyfile=/etc/etcd/private/etcd.key --etcd-servers=https://etcd01.socal.rr.com:2379/ --service-account-issuer=https://kcp01.socal.rr.com --service-account-signing-key-file=/etc/kubernetes/pki/ca.key --service-account-key-file=/etc/kubernetes/pki/sa.key --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key --service-cluster-ip-range=10.96.0.0/24
```
