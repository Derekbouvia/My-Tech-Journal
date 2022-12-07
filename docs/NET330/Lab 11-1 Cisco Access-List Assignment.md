# Lab 11-1 Cisco-Access List

## Commands to Configure Standard ACL's 

* To create Standard ACL's you need to run the following

```
device(config)# ip access-list standard Net1
device(config-std-nacl-Net1)# deny host 10.157.33.26
device(config-std-nacl-Net1)# deny 10.16.4.0 0.0.0.255
device(config-std-nacl-Net1)# permit any
```

* Then we must apply to interface by running the following            

  ```
  device(config)# int eth 1/1
  device(config-if-e10000-1/1)# ip access-group Net1 in
  ```

  

## Commands to Configure Extended ACL's

* To create Extended ACL's you need to run the following

```
(config)# ip access-list extended MYACL
(config-nacl-myacl)# deny tcp host 10.0.0.2 host 10.0.1.2 eq 80
(config-nacl-myacl)# deny tcp 10.0.0.0 0.0.0.255 10.0.1.0 0.0.0.255 eq 23
(config-nacl-myacl)# permit ip any any
```

* Then we must apply to interface by running the following

  ```
  (config)# interface fastEthernet 0/0
  (config-if)# ip access-group MYACL in
  ```

  

- **NOTE**

  There is a hidden "deny all" by default

  IN is entering the interface, OUT is leaving interface