# Setting Up Syslog

## Intro

syslog is used for message logging

# Syslog Server Setup

### First, allow syslog traffic through firewall

### On CentOS use command  to setup firewall rules



**firewall-cmd**



### Syslog uses TCP and UDP port 514 by default.

### firewall commands to use are



**firewall-cmd --add-port=514/tcp --permanent**



**firewall-cmd --add-port=514/udp --permanent**



### then reload



**firewall-cmd --reload**



### to see if rules were created successfully use command



**firewall-cmd --list-all**



### Now that firewall is configured now the syslog service needs to be set up. To do this we need to edit the /etc/rsyslog.conf file so that it can accept remote logs. The following lines need to be uncommented.

$ModLoad imtcp

$UDPServerRun 514



$ModLoad imtcp

$InputTCPServerRun 514



### Once this is done restart syslog server to apply changes with command



systemctl restart rsyslog



### SYSLOG Client Setup



Now, there needs to be a new file created in /etc/rsyslog.d/ and name it. In this case its sec350.conf 

In the file created type 

user.notice @172.16.150.5

The user portion indicate the syslog facility, the notice section indicated syslog priority, the single @ indicates traffic will be sent via UDP. If using TCP USE @@ 

The final section, 172.16.50.5 indicates the ip address of the remote syslog server.









