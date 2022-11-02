# Lab 9-2 BGP

## BGP Setup 

* BGP is an exterior protocol so the internal routes might already be configured. If this is the case then the internal routes can be shared with the external routers with the command

```
default-information originate
```

* To set up gateway of last resort run the commands

  **-NOTE-** 

  Change the network and router IP to the correct one for network

```
ip default network 192.168.2.0
```

```
ip route 0.0.0.0 0.0.0.0 192.168.2.1
```

* Once the border router is setup, the communication between BGP routers can be set up
* Run the following commands on each router in the BGP environment to set up BGP neighbors on a device.

```
enable
config t
router bpg 1010
neighbor 192.168.1.2 remote-as 2054
network 192.168.2.0 mask 255.255.255.252
```

​		**-NOTE-**

*  1010 is the AS for the current router, and 2054 is the AS for the neighbor router

* Since the network and mask sections are what the routers share with the BGP neighbors it needs to be repeated for each network the current router is connected to.