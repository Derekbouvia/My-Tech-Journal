# Lab Summary

In this lab we will use NAT destination rules to mask the presence of the DMZ

### Remove Static route from rw01

The first step towards hardening the network in this lab is to remove the static route to the DMZ (This can be seen by using the `ip route` command seen below)

`ip route`

This will show the route to the DMZ as listed below

```172.16.50.0/29 via 10.0.17.11X dev ens160 proto static metric 100```

In order to remove the static route we must run the following command as shown below(insert proper ip in place of X)

```sudo ip route del 172.16.50.0/29 via 10.0.17.11x dev ens160```

Now if we run `ip route` again, you should see that the static route has been removed.

### Port Forwarding

Now we must add a NAT destination rule so any traffic going to our firewalls WAN/eth0 interface (via port 80) will be forwarded to web01. We will make this happen on fw01 using a firewall configuration command as shown below.

`configure`

`set nat destination rule 10 description "HTTP->WEB01"`

`set nat destination rule 10 destination port 80`

`set nat destination rule 10 inbound-interface eth0`

`set nat destination rule 10 protocol tcp`

`set nat destination rule 10 translation address 172.16.50.3`

`set nat destination rule 10 translation port 80`

`commit`

`save`

We can now  check to see if the configuration is correct by running the command below

`show nat destination rule 10`

Now we can test what we have done by running the curl command with the ip address of rw01 as shown below

`curl http://10.0.17.110`

