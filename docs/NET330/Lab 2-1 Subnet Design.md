# VLANS In Packet Tracer

## Lab 2-1 Subnet Design

### General Network Information

The purpose of this lab was to design a network for a school and build in packet tracer using VLANS and using the CLI commands.

| VLAN | VLAN NAME   | Hosts Needed | Network    | Netmask         | Router Address |
| ---- | ----------- | ------------ | ---------- | --------------- | -------------- |
| 200  | StuWireless | 900          | 10.7.0.0   | 255.255.252.0   | 10.7.0.1       |
| 210  | FSWireless  | 650          | 10.7.4.0   | 255.255.252.0   | 10.7.4.1       |
| 110  | Student     | 450          | 10.7.8.0   | 255.255.254.0   | 10.7.8.1       |
| 1    | Management  | 250          | 10.7.10.0  | 255.255.255.0   | 10.7.10.1      |
| 100  | FacStaff    | 200          | 10.7.11.0  | 255.255.255.0   | 10.7.11.1      |
| 130  | Stulab1     | 35           | 10.7.12.0  | 255.255.255.192 | 10.7.12.1      |
| 140  | Stulab2     | 35           | 10.7.12.64 | 255.255.255.192 | 10.7.12.65     |

| Prompt                 | Mode                   |
| ---------------------- | ---------------------- |
| Router>                | User EXEC Mode         |
| Router#                | Privileged EXEC Mode   |
| Router(config)#        | Configuration Mode     |
| Router(config-if)#     | Interface Config Mode  |
| Router(config-router)# | Router Config Mode     |
| Router(config-line)#   | Line Level Config Mode |



## VLAN Setup

To set up VLANS that are universal across all the switches

```
enable
config t
vlan 100 name FacStaff
vlan 110 name Student
interface range fa 0/4-12
switchport access vlan 100
interface range fa 0/13-20
switchport access vlan 110
exit
exit
copy running-config startup-config
```

* For switches that require lab VLANs, run the commands below on the appropriate switch before the exit commands

```
vlan 130 name StuLab1
interface range fa 0/21-24
switchport access vlan 130

or

vlan 140 name SuLab1
interface range fa 0/21-24
switchport access vlan 140
```

* To configure trunk ports on switches
* Use as necessary for switches that connect to multiple other switches

```
enable
config t
interface fa 0/1
switchport mode trunk
exit
exit
copy
copy running-config startup-config
```

## Routing Setup

In this lab the East-Core-Switch-01 acted as a router. The VLAN configuration above was run on the machine to set up routing as well as the following

```
interface vlan 100
ip address 10.7.11.1 255.255.255.254
interface vlan 110
ip address 10.7.8.1 255.255.254.0
interface vlan 130
ip address 10.7.12.1 255.255.255.192
interface vlan 140
ip address 10.7.12.65 255.255.255.192
```

**-NOTE-**

Do not forget to save the running config to prevent losing any settings made







