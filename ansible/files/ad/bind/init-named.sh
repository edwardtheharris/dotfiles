#!/bin/bash

chgrp named /var/lib/samba/private/dns.keytab
chmod g+r /var/lib/samba/private/dns.keytab
touch /var/log/named.log
chown root:named /var/log/named.log
chmod 664 /var/log/named.log

systemctl enable named
exec systemctl start named
