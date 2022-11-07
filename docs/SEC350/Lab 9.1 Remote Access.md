# Lab Summary

In this lab we are configuring a Wireguard VPN tunnel for a remote Administrator

### Install Windows Wireguard Client on traveler

* First thing that we need to do is download the Windows Installer at http://www.wireguard.com/install/

* Follow through with prompts for the installer

### Create new VPN Tunnel

* Locate and click drop-down arrow next to "Add Tunnel"
* Select empty tunnel option
* Do not forget to make note of the public key

### Configure wg0 on edge01

* The next step is to configure Wireguard interface on the firewall, to do this we need to execute the following commands below on edge01...

`configure`

`run generate pki wireguard key-pair install interface wg0`

`set interfaces wireguard wg0 address '10.0.99.1/24'`

`set interfaces wireguard wg0 peer [PEER-HOSTNAME] allowed-ips '10.0.99.100/32'`

`set interfaces wireguard wg0 port '51280'`

`commit`

`save`

* **[Reminder] - Make sure to keep the public key edge01 generated available since it will be needed in the next section**

### Wireguard configuration on traveler

* On traveler box where we are configuring Wireguard, right click the desired tunnel (the one made earlier) and select Edit
* Under PrivateKey add an address which will be set to the host address for the wg0 network that was just estabished. 
* Add a section titled [Peer].
* Copy the public key that was generated on edge01 to traveler and insert under the peer header
* Set the allowed IPs to represent the wg network and the mgmt network.
* Set the Endpoint to the WAN IP of edge01.

### Firewalls 

Since there is a new interface there needs to be two more network firewalls to be created.

### VPN-to-LAN

`configure`

`set firewall name VPN-to-LAN default-action drop`

`set firewall name VPN-to-LAN rule 1 action accept`

`set firewall name VPN-to-LAN rule 1 state established enable`

`set firewall name VPN-to-LAN rule 10 description ''Allow Traveler-->mgmt02 via tcp/3389"`

`set firewall name VPN-to-LAN rule 10 action accept`

`set firewall name VPN-to-LAN rule 10 source address 10.0.99.100`

`set firewall name VPN-to-LAN rule 10 destination address 172.16.200.11`

`set firewall name VPN-to-LAN rule 10 destination port 3389`

`commit`

`save`

### LAN-to-VPN

`configure`

`set firewall name LAN-to-VPN default-action drop`

`set firewall name LAN-to-VPN rule 1 action accept`

`set firewall name LAN-to-VPN rule 1 state established enable`

`commit`

`save`

### VPN Zone

A new zone policy for the wg0 interface needs to be created and related to the LAN

`configure`

`set zone-policy zone VPN interface wg0`

`set zone-policy zone VPN from LAN firewall name LAN-to-VPN`

`commit`

`save`

### LAN Zone

`configure`

`set zone-policy zone LAN from VPN firewall name VPN-to-LAN`

`commit`

`save`

### LAN-to-MGMT

`set firewall name LAN-to-MGMT rule 30 action accept`

`set firewall name LAN-to-MGMT rule 30 description "Allow Traveler->mgmt02 via tcp/3389"`

`set firewall name LAN-to-MGMT rule 30 destination address 172.16.200.11`

`set firewall name LAN-to-MGMT rule 30 destination port 3389`

`set firewall name LAN-to-MGMT rule 30 protocol tcp`

`set firewall name LAN-to-MGMT rule 30 source address 10.0.99.100`

`commit`

`save`

### Remote Desktop Protocol Setup and Configuration

* To set up Remote Desktop Protocol between mgmt02 and Traveler, the settings need to be updated on the management box once we finish configuring the firewall.

* First, navigate to "Control Panel"
* Then "System and Security"
* From there "Allow remote access"
* **To do this for the named ADM account make sure to be logged in as that user when following these steps.**
* Open "System Properties" Window
* Select "Allow remote Connections to this computer"
* Click "Select Users..."
* From here there should be a message that says "[AdminUser] already has Access"
* If so, click "OK"
* then "Apply"
* then "OK" to make the specified changes
* At this point it should be possible to Remote Desktop from Traveler as the named admin user to mgmt02.

### Firewall Configurations 

[**fw-mgmt**](https://github.com/Derekbouvia/My-Tech-Journal/blob/master/docs/SEC350/fw-mgmt.config.week10.txt)

[**edge01**](https://github.com/Derekbouvia/My-Tech-Journal/blob/master/docs/SEC350/edge01-config.week10.txt)

