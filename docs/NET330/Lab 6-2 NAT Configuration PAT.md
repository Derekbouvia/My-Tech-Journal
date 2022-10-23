# Lab 5-2 NAT PAT

## Commands to configure PAT 

* When configuring PAT we need to grant access to a range. The following commands will setup PAT.

```
ip nat pool PoolName RANGE-START RANGE-END netmask NETMASK
access-list 1 permit IP CLIENT-NETMASK
ip nat inside source list 1 pool PoolName overload

ip nat pool PATPool 69.69.69.69 69.69.69.69 netmask 255.0.0.0
access-list 1 permit 10.0.0.0 0.0.0.255
ip nat inside source list 1 pool PATPool overload
```

* Using Simulation Mode and protocol filters in Packet Tracer

Simulation mode allows you to see how the network traffic will flow. In this mode you can see where packets are getting dropped. You can also edit the filter list to only show specific traffic. So if you wanted to only see ICMP traffic in the network you could unselect all the other protocols in the filter.