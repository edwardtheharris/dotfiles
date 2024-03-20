---
abstract: Notes for getting etcd up and running.
authors: Xander Harris
date: 2024-02-26
title: etcd
---

The Ansible playbook in this directory will do the following.

1. Install `etcd` and `etcdadm`
2. Add etcd configuration.
3. Create etcd certs.

    <!-- markdownlint-disable -->
    ```{code-block} shell
    openssl genpkey -algorithm RSA -out /etc/etcd/private/peer.key
    openssl genpkey -algorithm RSA -out /etc/etcd/private/etcd.key
    openssl req -new -key /etc/etcd/private/peer.key -out /etc/etcd/pki/peer.csr
    openssl req -new -key /etc/etcd/private/etcd.key -out /etc/etcd/pki/etcd.csr
    openssl x509 -req -in /etc/etcd/pki/peer.csr -CA /etc/ssl/certs/dc01.bundle.crt -CAkey /etc/ssl/private/dc01.ca.key -CAcreateserial -out /etc/etcd/pki/peer.crt -days 36500 -extensions v3_req -extfile /etc/ssl/openssl.cnf
    openssl x509 -req -in /etc/etcd/pki/etcd.csr -CA /etc/ssl/certs/dc01.bundle.crt -CAkey /etc/ssl/private/dc01.ca.key -CAcreateserial -out /etc/etcd/pki/etcd.crt -days 36500 -extensions v3_req -extfile /etc/ssl/openssl.cnf
    ```
    <!--markdownlint-enable -->

4. Start and enable the `etcd` service.

    ```{code-block} shell
    systemctl enable etcd
    systemctl start etcd
    ```
