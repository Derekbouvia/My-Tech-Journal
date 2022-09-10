# Setting Up Syslog

## Intro

syslog is used for message logging

# Syslog Server Setup

### First, allow syslog traffic through firewall

### On CentOS use command  to setup firewall rules



**firewall-cmd**



Syslog uses TCP and UDP port 514 by default.

firewall commands to use are



**firewall-cmd --add-port=514/tcp --permanent**



**firewall-cmd --add-port=514/udp --permanent**



then reload



**firewall-cmd --reload**



to see if rules were created successfully use command



**firewall-cmd --list-all**



