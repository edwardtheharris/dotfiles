#!/bin/bash

# Add an A record
samba-tool dns add dc1.brick-house.loc brick-house.loc dns A 192.168.1.186 -A ~/.samba/private/auth

# Add the corresponding reverse lookup
samba-tool dns add dc1.brick-house.loc 168.192.in-addr.arpa 186.1 PTR ns.brick-house.loc -A ~/.samba/private/auth
