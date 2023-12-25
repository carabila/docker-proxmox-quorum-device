#!/bin/bash

/usr/bin/corosync-qnetd 
/usr/sbin/sshd -D &

wait -n

exit $?
