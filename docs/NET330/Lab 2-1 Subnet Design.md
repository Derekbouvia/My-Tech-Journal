# VLANS In Packet Tracer

## Lab 2-1 Subnet Design

### General Network Information

The purpose of this lab was to design a network for a school and build in packet tracer using VLANS and using the CLI commands.

| VLAN | VLAN NAME   | Hosts Needed | Network    | Netmask | Router Address |
| ---- | ----------- | ------------ | ---------- | ------- | -------------- |
| 200  | StuWireless | 900          | 10.7.0.0   | /22     | 10.7.0.1       |
| 210  | FSWireless  | 650          | 10.7.4.0   | /22     | 10.7.4.1       |
| 110  | Student     | 450          | 10.7.8.0   | /23     | 10.7.8.1       |
| 1    | Management  | 250          | 10.7.10.0  | /24     | 10.7.10.1      |
| 100  | FacStaff    | 200          | 10.7.11.0  | /24     | 10.7.11.1      |
| 130  | Stulab1     | 35           | 10.7.12.0  | /26     | 10.7.12.1      |
| 140  | Stulab2     | 35           | 10.7.12.64 | /26     | 10.7.12.65     |

| Prompt                 | Mode                   |
| ---------------------- | ---------------------- |
| Router>                | User EXEC Mode         |
| Router#                | Privileged EXEC Mode   |
| Router(config)#        | Configuration Mode     |
| Router(config-if)#     | Interface Config Mode  |
| Router(config-router)# | Router Config Mode     |
| Router(config-line)#   | Line Level Config Mode |



## Cisco Switch and Router Commands

#### To Assign and Create VLANS on Switch

`enable`

#### Gain access to configure type

`switch1(config)# vlan <number>`

`switch1(config-vlan)# name <vlan-name>`

#### To select and name new vlan

`interface <range(if applicable)> FastEthernet 0/1(or 0/1-14 if range)`

#### To select an interface witin the router that you want to deal with type:

 `switchport mode access`

`switchport access vlan <vlan number>`

#### To Assign ports to these interfaces make sure to type:

`switch# sh vlan (brief)` Either show all vlan info of show brief amount of vlan info

#### To Enable Routing from Switch

`ip routing`(turns on routing on multilayer switches)

`ip address 10.25.100.1 255.255.255.0`This sets the ip address of 10.25.100.1 for vlan 100 on a routing switch)

#### To Connect  Two Routers or Switches with VLANS

Trunk Port. Change the adapter that is to be connected to "Trunk" using dropdown.













