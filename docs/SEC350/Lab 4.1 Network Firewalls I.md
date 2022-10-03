# Lab Summary

In this lab we managed network traffic between the WAN, LAN, MGMT AND DMZ

## Prerequisites to starting Lab

rw01 can ping web01 and browse to web01

web01 can ping wks01 by using this command below to open up traffic

`netsh advfirewall firewall add rule name="ICMP Allow incoming v4 echo request" protocol=icmpv4:8,any dir=in action=allow`

web01 can ping log01

log01 can ping wks01

log01 can ping web01

## Update VyOS firmware on both firewalls to mitigate a logging flaw

find the ISO listed below online

**vyos-1.4-rolling-202209130217-amd64.iso**

type the address listed below follow prompts then reboot

add system image https://s3-us.vyos.io/rolling/current/vyos-1.4-rolling-202209130217-amd64.iso

## Configure fw01

We need to link the firewall zones to the interfaces by entering the commands below

`set zone-policy zone WAN interface eth0`

`set zone-policy zone DMZ interface eth1`

`set zone policy zone LAN interface eth2`

## Configure Default Drop Rules Across fw01

### WAN and DMZ

Establish the drop rules listed below

`set firewall name WAN-to-DMZ default-action drop`

`set firewall name WAN-to-DMZ enable-default-log`

`set firewall name DMZ-to-WAN default-action drop`

`set firewall name DMZ-to-WAN enable-default-log`

`set zone-policy zone DMZ from WAN firewall name WAN-to-DMZ`

`set zone-policy zone WAN from DMZ firewall name DMZ-to-WAN`

`commit`

`save`

Now we need to do a quick test and see if it fails when we ping web01 from rw01

To monitor firewall logs use the command below

`tail -f /var/log/messages | grep WAN`

If the attempted connection is made again than we should see the DPT (Destination Port) and DST (Destination Address) in the logs. If so, that means the default drop rule for WAN-to-DMZ via eth0 has been established

Next, we must allow HTTP traffic from the WAN to the DMZ-based web01 server by typing the commands below

`configure`

`set firewall name WAN-to-DMZ rule 10 action accept`

`set firewall name WAN-to-DMZ rule 10 destination address 172.16.50.3`

`set firewall name WAN-to-DMZ rule 10 destination port 80`

`set firewall name 	WAN-to-DMZ rule 10 protocol tcp`

`set firewall name WAN-to-DMZ rule 10 description "Allow WAN Access to Web01 HTTP"`

The DMZ-to-WAN firewall needs to be told that authorized connections started in the WAN are allowed back out so we need to do the following below:

## Allowing Established Connections back out again

First we must configure the webpage so when we test the connection we will have a message showing whats included. To do that, on web01 navigate to 

`/var/www/html`

then to edit the file type

`sudo vi index.html`

then write what we want the page to say like

`Welcome to the web01 page!`

Back on fw01 we need to finish the firewall configuration so that the connection can be completed between the WAN and DMZ networks. 

To open up traffic run the following commands:

`configure`

`set firewall name DMZ-to-WAN rule 1 action accept`

`set firewall name DMZ-to-WAN rule 1 state established enable`

`commit`

`save`

Now when we curl the webserver from rw01 we can now see the contents of the webpage by typing the command below

`curl http://172.16.50.3`

## DMZ and LAN Traffic

Now we will create some more default firewalls that will be linked to zone policies. 

On fw01 run the following commands:

`configure`

`set firewall name DMZ-to-LAN default-action drop`

`set firewall name DMZ-to-LAN enable-default-log`

`set firewall name LAN-to-DMZ default-action drop`

`set firewall name LAN-to-DMZ enable-default-log`

`set zone-policy zone DMZ from LAN firewall name LAN-to-DMZ`

`set zone-policy zone LAN from DMZ firewall name DMZ-to-LAN`

`commit`

`save`

We can now use the command below to start debugging firewall issues so we can open up the correct ports

`tail -f /var/log/messages | grep LAN`

An effective way to check and see what ports are being used on web01 was to run a test log and sign in as an invalid user on to the box. This triggered 1514/tcp anf 514/udp and is in the dropped packets in the `/var/log/messages` file on fw01 which means the ports need to be opened up

## DMZ-to-LAN

In order to open up these ports the commands below must be ran to configure the firewall

`configure`

`set firewall name DMZ-to-LAN rule 10 action accept`

`set firewall name DMZ-to-LAN rule 10 description "SYSLOG to log01"`

`set firewall name DMZ-to-LAN rule 10 destination address 172.16.200.10`

`set firewall name DMZ-to-LAN rule 10 destination port 514`

`set firewall name DMZ-to-LAN rule 10 protocol udp`

`set firewall name DMZ-toLAN rule 15 action accept`

`set firewall name DMZ-to-LAN rule 15 description "wazuh agent to log01"`

`set firewall name DMZ-to-LAN rule 15 destination address 172.16.200.10`

`set firewall name DMZ-to-LAN rule 15 destination port 1514`

`set firewall name DMZ-to-LAN rule 15 protocol tcp`

`commit`

`save`

Now its important to find LAN-to-DMZ traffic that has been dropped that has a SPT=1514. This is a tcp connection so we need to allow established back through the related firewall (LAN-to-DMZ). We can check this with the command below

`cat /var/log/messages | grep LAN-to-DMZ | grep "SPT=1514"`

With this information we can determine what the destination address and Destination port is, and set up a returning firewall rule by using the commands below

`configure`

`set firewall name LAN-to-DMZ rule action accept`

`set firewall name WAN-to-LAN rule 1 state established enable`

`commit`

`save`

## LAN-to-WAN

This firewall needs to be configured in an open manner so the LAN clients can initiate WAN connections. We do this by running the commands below

`configure`

`set firewall name LAN-to-WAN default-action drop`

`set firewall name LAN-to-WAN enable-default-log`

`set zone-policy zone WAN from LAN firewall name LAN-to-WAN`

`commit`

`save`

`set firewall name LAN-to-WAN rule 1 action accept`

`commit`

`save`

The configuration should look like this after:



