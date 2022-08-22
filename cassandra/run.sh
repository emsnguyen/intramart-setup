#!/bin/bash

/etc/init.d/sshd restart
cassandra &

touch /var/log/cassandra/system.log
tail -F /var/log/cassandra/system.log