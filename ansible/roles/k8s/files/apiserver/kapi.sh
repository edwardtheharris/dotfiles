#!/bin/bash -
#===============================================================================
#
#          FILE: kapi.sh
#
#         USAGE: ./kapi.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (),
#  ORGANIZATION:
#       CREATED: 02/09/2024 16:07
#      REVISION:  ---
#===============================================================================

/usr/bin/kube-apiserver --bind-address 0.0.0.0 -v 3 \
    --enable-bootstrap-token-auth \
    --anonymous-auth=false \
    --service-cluster-ip-range 10.0.0.0/12 \
    --authorization-mode RBAC \
    --etcd-cafile='/etc/etcd/pki/ca.crt' \
    --etcd-certfile='/etc/etcd/pki/server.crt' \
    --etcd-keyfile='/etc/etcd/pki/server.key' \
    --etcd-servers 'https://kcp01.int.bh.loc:2379' \
    --service-account-issuer 'https://kcp01.int.bh.loc:5664/dex' \
    --service-account-signing-key-file=/etc/dex/ca-key.pem \
    --service-account-key-file=/etc/dex/key.pem \
    --oidc-issuer-url='https://192.168.1.50:5554/dex' \
    --oidc-client-id=bare-metal \
    --oidc-ca-file='/etc/dex/kcp.crt' \
    --oidc-username-claim=email \
    --oidc-groups-claim=groups
