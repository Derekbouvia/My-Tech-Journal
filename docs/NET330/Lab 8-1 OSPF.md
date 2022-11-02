# Lab 8-1 OSPF

## OSPF Setup 

* To set up OSPF on a router standard interface setup needs to happen first.

```
enable
config t
interface gig 0/0
ip address 10.7.1.1 255.255.255.248
no shutdown
exit
exit
copy running-config startup-config
```

* Now OSPF needs to be configured

```
enable
config t
router ospf 1
network 10.7.1.0 0.0.0.7 area 0
exit
exit
copy running-config startup-config
```

* To check the status of the OSPF 

```
show ip route
show ip ospf
show ip ospf interface gig 0/0
```

useful info-

*  With OSPF we set up a wildcard mask, so the subnet section is inversed.

* The 0 after area on the 4th line down represents the specific area ID, which has to be the same for all routers in the area.