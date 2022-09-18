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

## Configure mgmt01 for NAT and DNS Forwarding

### Commands 

`configure`

`set nat source rule 15 description NAT from DMZ to LAN`

`set nat source rule 15 outbound-interface eth0`

`set nat source rule 15 source address 172.16.150.0/24`

`set nat source rule 15 translation address masquerade`

`commit`

`save`

## To check to see if setup is correct try pinging 8.8.8.8

### Configure DNS Forwarding

#### Tell fw01- to forward DNS Requests from DMZ Interface

`set service dns forwarding listen-address 172.16.150.2`

`set service dns forwarding allow-from 172.16.150.0/24`

`set service dns forwarding system`

`commit`

`save`

## To check to see if DNS is resolved ping google.com

`ping -c1 google.com`

- REMINDER 

  Make sure  mgmt-01 settings are set to manual and restart network





### Now that firewall is configured now the syslog service needs to be set up. To do this we need to edit the /etc/rsyslog.conf file so that it can accept remote logs. The following lines need to be uncommented.

$ModLoad imtcp

$UDPServerRun 514



$ModLoad imtcp

$InputTCPServerRun 514



### Once this is done restart syslog server to apply changes with command



systemctl restart rsyslog



## Syslog Client Setup

Now, there needs to be a new file created in /etc/rsyslog.d/ and name it. In this case its sec350.conf 

In the file created type 

user.notice @172.16.150.5

The user portion indicate the syslog facility, the notice section indicated syslog priority, the single @ indicates traffic will be sent via UDP. If using TCP USE @@ 

The final section, 172.16.50.5 indicates the ip address of the remote syslog server.

Now we must restart the syslog service to apply with command



systemctl restart rsyslog



To test if logs are being sent to the server use command

logger -t test TESTMESSAGE



Make sure to use this command on test server*



tail -f /var/log/messages











