#!/bin/bash -
#===============================================================================
#
#          FILE: kcm.sh
#
#         USAGE: /usr/bin/kcm.sh
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

/usr/bin/kube-controller-manager --master='https://kubernetes.default.service:6443'
