| Subnet Name | VLAN ID | Hosts Needed | Hosts Available | Subnet Mask /CIDR | Usable Range          | Gateway Address |
| ----------- | ------- | ------------ | --------------- | ----------------- | --------------------- | --------------- |
| Clinic      | 20      | 300          | 510             | 255.255.254.0 /23 | 10.6.0.1-10.6.0.1.254 | 10.6.0.1        |
| Visitor     | 30      | 300          | 510             | 255.255.254.0 /23 | 10.6.2.1 - 10.6.3.254 | 10.16.2.1       |
| Office      | 40      | 300          | 510             | 255.255.254.0 /23 | 10.6.4.1 - 10.6.5.254 | 10.6.4.1        |
| Default     | 1       | 150          | 254             | 255.255.255.0 /23 | 10.6.6.1 - 10.6.6.254 | 10.6.6.1        |
| Counseling  | 50      | 150          | 254             | 255.255.255.0 /24 | 10.6.7.1 - 10.6.7.254 | 10.16.7.1       |

# VLANs

These are the commands that will create a VLAN with a specific ID and give it an appropriate name for it and these commands were run on the 2960-24TT switches and 2560-24PS.

`vlan 20`

`name Clinic`

`vlan 30`

`name Visitor`

`vlan 40`

`name Office`

`vlan 50`

`name Counseling`

These commands below were used to set access points for client machines on the 2960-24TT switches

`interface range fa 0/5-11`

`switchport access vlan 20`

`interface range fa 0/12-15`

`switchport access vlan 30`

`interface range fa 0/16-21`

`switchport access vlan 40`

The commands I used below connected the switches to each other via trunk ports. These were for interface fa 0/24 but may differ depending on the interface

`interface fa 0/24`

`switchport trunk encapsulation dotlq`

`switchport mode trunk`

Since VLAN1 was default it needs to be enabled with this command below

`interface vlan 1`

`no shutdown`

# Gateway Settings

To set the IP Address for the gateway on the VLANS I ran the commands below. They were only ran on the 3560-24PS switch

`interface vlan 20`

`ip address 10.6.0.1 255.255.254.0`

`interface vlan 30`

`ip address 10.6.2.1 255.255.254.0`

`interface vlan 40`

`ip address 10.6.4.1 255.255.254.0`

`interface vlan 1`

`ip address 10.6.6.1 255.255.255.0`

`interface vlan 50`

`ip address 10.6.7.1 255.255.255.0`

To set up routing I ran the command 

`ip routing`

The IP 10.6.6.2 is for the DHCP server in this environment. To configure the IP helpers for the DHCP server I ran the commands below.

`interface vlan 20`

`ip helper-address 10.6.6.2`

`interface vlan 30`

`ip helper-address 10.6.6.2`

`interface vlan 40`

`ip helper-address 10.6.6.2`

`interface vlan 50`

`ip helper-address 10.6.6.2`

# DHCP

To configure a server on a network to provide DHCP I selected End Devices then server and connected it in the network. Then Selected the server and then went to services. Then go to DHCP and configure the inputs as shown below.

Interface `FastEthernet0` service `on`

Pool name `serverPool`

Default Gateway `10.6.6.1`

DNS Server `0.0.0.0`

Start IP Address  `10` `6` `6` `0` 

Subnet Mask `255` `255` `255` `0` 

Max Number of Users `150`

TFTP Server: `0.0.0.0`

WLC Address: `0.0.0.0`

| Pool Name  | Default Gateway | DNS Server | Start IP Address | Subnet Mask   | Max User | TFTP Server | WLC Address |
| ---------- | --------------- | ---------- | ---------------- | ------------- | -------- | ----------- | ----------- |
| serverPool | 10.6.6.1        | 0.0.0.0    | 10.6.6.0         | 255.255.255.0 | 150      | 0.0.0.0     | 0.0.0.0     |
| Counseling | 10.6.7.1        | 10.6.6.3   | 10.6.7.2         | 255.255.255.0 | 150      | 0.0.0.0     | 0.0.0.0     |
| Office     | 10.6.4.1        | 10.6.6.3   | 10.6.4.2         | 255.255.254.0 | 300      | 0.0.0.0     | 0.0.0.0     |
| Clinic     | 10.6.0.1        | 10.6.6.3   | 10.6.0.2         | 255.255.254.0 | 300      | 0.0.0.0     | 0.0.0.0     |
| Visitor    | 10.6.2.1        | 10.6.6.3   | 10.6.2.2         | 255.255.254.0 | 300      | 0.0.0.0     | 0.0.0.0     |

Create a new pool then *ADD

!Do not save(save will override the one being worked on)

