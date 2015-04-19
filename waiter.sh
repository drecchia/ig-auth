#!/bin/sh
while : ;do
tail -n 5 '/var/log/messages'|grep " pppd\["|grep ' remote ' 1> /dev/null && { ~/.IGauth/IGauth.sh;exit;} 
~/.IGauth/usleep 200000
done
