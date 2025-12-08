#!/bin/bash

install -d /var/lib/samba/ntp_signd
chown root:ntp /var/lib/samba/ntp_signd
chmod 0750 /var/lib/samba/ntp_signd

systemctl enable ntpd
exec systemctl start ntpd
