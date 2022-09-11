# VLANS In Packet Tracer

## Lab 2-1 Subnet Design

### General Network Information

The purpose of this lab was to design a network for a school and build in packet tracer using VLANS and using the CLI commands.

| VLAN | VLAN NAME   | Hosts Needed | Network    | Netmask | Router Address |
| ---- | ----------- | ------------ | ---------- | ------- | -------------- |
| 200  | StuWireless | 900          | 10.7.0.0   | /22     | 10.2.0.1       |
| 210  | FSWireless  | 650          | 10.7.4.0   | /22     | 10.2.4.1       |
| 110  | Student     | 450          | 10.7.8.0   | /23     | 10.2.8.1       |
| 1    | Management  | 250          | 10.7.10.0  | /24     | 10.2.10.1      |
| 100  | FacStaff    | 200          | 10.7.11.0  | /24     | 10.2.11.1      |
| 130  | Stulab1     | 35           | 10.7.12.0  | /26     | 10.2.12.1      |
| 140  | Stulab2     | 35           | 10.7.12.64 | /26     | 10.2.12.65     |

## Cisco Switch and Router Commands

#### To Assign and Create VLANS on Switch

`enable`





