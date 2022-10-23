# Static NAT

## Setting NAT interfaces

When  we set up NAT we need to specify the internal and external interfaces. The internal interface (inside) would be for the lan and the external (outside) is for the WAN. below shows an example using fast ethernet 1 as the internal network and fast ethernet 0 as the wan network.

```interface fa 0/0
R1(config)#interface fastEthernet 0/0
R1(config-if)#ip nat inside
R1(config-if)#exit
R1(config)#interface serial 0/0/0
R1(config-if)#ip nat outside 
R1(config-if)#exit
```

commands for static NAT with example:

* NAT can be mapped statically so the same internal IP will always get a specific external IP. To do this you would run the following.
  ```R1(config)#ip nat inside source static 10.0.0.2 50.0.0.1```

