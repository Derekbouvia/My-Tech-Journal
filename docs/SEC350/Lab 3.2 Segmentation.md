# Lab Summary

The goal of this lab was to segment the existing network and add another network so that log01 is in a safe place

## Configure wks01

### Hardwire

Before turning on VM the network adapter must be configured to the LAN

## Setting Hostname

Settings --> System--> About--> "Rename this PC"--> ENTER HOSTNAME--> "Next"--> "Restart Later"

## Networking wks01

Settings--> Network & Internet--> Ethernet -->Change adapter options ->> Ethernet0--> Properties--> Internet Protocol Version 4 (TCP/IPV4) --> "Use the following IP Address:" ENTER IP, ENTER SUBNET, ENTER GATEWAY, ENTER DNS--> "OK-->"OK"-->"Close"--> WINDOWS ICON--> Power --> Restart

## Adding Name User to wks01

open command prompt as adm and add a new user with commands below

`net user [username] [password] /add`

`net user`will confirm account creation

add the user to the admin group by using the following command

`net localgroup administrators [username] /add`

## Setting up fw-mgmt

The mgmt firewall will protect administrator systems from main LAN. We start by setting up the network adapters 1 and 2 to the LAN and MGMT networks, deleting interfaces,setting interfaces with a description and address, configuring gateway and dns, DNS forwarding on fw-mgmt run the following commands below

`configure`

`set system host-name fw-mgmt-derek`

`delete interfaces ethernet etho address dhcp`

`delete interfaces ethernet eth1 address dhcp`

`set interfaces ethernet eth0 description DEREK-LAN`

`set interfaces ethernet eth1 description DEREK-MGMT`

`set interfaces ethernet eth0 address 172.16.150.3/24`

`set interfaces ethernet eth1 address 172.16.200.2/28 `

`set protocols static route 0.0.0.0/0 next-hop 172.16.150.2`

`set system name-server 172.16.150.2`

`set service dns forwarding listen-address 172.16.200.2`

`set service dns forwarding allow-from 172.16.200.0/28`

`set service dns forwarding system`

`commit`

`save`

`reboot`

## Configuring mgmt02

Assign mgmt02to the MGMT network adapter

Change the hostname, add an administrative user, network box(see above) to the configs below

`IP Address: 172.16.200.11`

`Netmask: 255.255.255.240`

`Gateway: 172.16.200.2`

`DNS: 172.16.200.2`

## RIP on fw01 and fw-mgmt

We will use RIP routing to allow fw01 and fw-mgmt to know each others networks. Below are the commands to enable RIP on the LAN and advertise the DMZ on fw01

`set protocols rip interface eth2`

`set protocols rip network 172.16.50.0/29`

Now we will enable RIP on the LAN and advertise MGMT on fw-mgmt box with the commands below

`set protocols rip interface eth0`

`set protocols rip network 172.16.200.0/28`

Next we will set up NAT from MGMT to WAN on fw01 with the commands below

`configure`

`set nat source rule 20 description "NAT FROM MGMT to WAN"`

`set nat source rule 20 outbound-interface eth0`

`set nat source rule 20 source address 172.16.200.0/28`

`set nat source rule 20 translation address masquerade`

`commit`

`save`

`exit`

## Now we must move log01 again

## Hardwire

Change network adapter from LAN to MGMT

## Networking 

Now we can use nmtui to edit the IP, gateway and DNS address of log01 so that it is in the MGMT network

Reboot.

FW01 and web01 have syslog configurations that point to an old log01 IP so we need to update those.

## Updating web01

Navigate to the ossec.conf file as root and change server address, then restart service using the commands below

`vi /var/ossec/etc/ossec.conf`

locate the server address and update then restart service with the command below

`systemctl restart wazuh-agent`

Navigate to drop in file then update IP Address with command below

`vi /etc/rsyslog.d/sec350.conf`

Now we must change the IP on both lines and save and exit

`:wq!`

## Updating fw01

Now we must update the syslog settings so that fw01 sends logs to the correct IP by running the following commands below

`configure`

`delete system syslog host 172.16.150.5`

`commit`

`save`

`set system syslog host 172.16.200.10 facility authpriv level info`

`commit`

`save`

## Logging

Now we must test the system to ensure everything is running correctly by using logger to check if log01 is receiving logs from web01 by running the command below

`logger -t test "This is a test message to log01 on the management network"`

On log01 navigate to this location listed below as a Root user

`/var/log/remote-syslog/web01-derek`

run the command below to locate the test log

`tail *.test.log`

my code for firewall configurations up to week 3 can be found in the code section by following these links.. 

[fw01](https://github.com/Derekbouvia/My-Tech-Journal/blob/master/docs/SEC350/fw01.config.week3.txt)	

[fw-mgmt](https://github.com/Derekbouvia/My-Tech-Journal/blob/master/docs/SEC350/fw-mgmt.config.week3.txt)



