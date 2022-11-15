

# Lab Summary

In this lab we installed a certificate authority on the new Rocky Linux system called ca so the certificates can be signed and issued to nginx and http services can be migrated to https/tls

# AD/DNS

### Configure mgmt02 to be a Windows Domain Controller (yourname.local)

* First we need to navigate to server manager on mgmt02

* Once in server manager, select "Manage" in the taskbar

* Make sure to use role-based or feature-based installation. 

* Select mgmt02 as the server to install roles and features.

* Go to the next page and then check box next to "Active Directory Domain Services", and go through the installation process. 

* After installation is done, go to the flag in the taskbar, select it, then click the link titled "Promote this server to a domain controller". 

* Select "Add a new forest" as the deployment operation with yourname.local as the naming convention. 

* Then, we are asked to enter a Directory Services Restore Mode (DSRM) password--

  **-NOTE-**

  **Be sure to make note of this in case it is needed later!**

*  Remaining settings kept at default

* Restart server after installation and log back in

## Configure forward and reverse DNS records 

* **This will be done for all hosts except traveler and wks1**

* To do this, Open server manager on mgmt02
* select DNS on sidebar
* right-click the server, and open DNS Manager. 

* Now, we add A and PTR records for each host on the network except for traveler and wks01
* First we go to the yourname.local folder under the Forward Lookup Zones folder
* Select "New Host (A or AAAA)..." which will open a window that requests the hostname, IP address, PTR records, etc. 

		**-NOTE-**
	
		**Make sure to specify LAN address for edge01 and MGMT address for fw-mgmt when adding the firewalls**

* Once the A records are done we then navigate to the "Reverse Lookup Zones" folder ->right-click -> add new zone.
* Continue with defaults, and enter each of the DMZ, MGMT, and LAN network addresses as different zones 
* Next we return to the Forward Lookup Zones folder and double-click on each A record
*  Make sure the "Add associated PTR record" option is unselected and then re-selected -> hit "Apply" then "OK". This will add PTR records for each of the hosts. 
* Refresh the DNS Manager 
* Check the "Reverse Lookup Zones" folder to make sure that all the PTR records were successfully added.

## Joining  wks1 to the domain

* We need to now add a firewall rule on fw-mgmt so that we can add wks01 to the domain succesfully

* Navigate to fw-mgmt box and enter the commands below so that the 172.16.150.0/24 subnet can initiate connections from the LAN to the Domain Controller

`Configure`

`set firewall name LAN-to-MGMT rule 35 action accept`

`set firewall name LAN-to-MGMT rule 35 description "Allow LAN addresses -> DC"`

`set firewall name LAN-to-MGMT rule 35 destination address 172.16.200.11`

`set firewall name LAN-to-MGMT rule 35 source address 172.16.150.0/24`

`commit`

`save`



* Since the firewall rule has been added  we can now add wks01 to the Domain

* On wks1...open control panel ->configure network settings to point to the new DNS
*  Now we go ahead and point to mgmt02 IP
* Apply changes
*  Go to Control Panel -> System and Security -> System -> Change settings -> Change -> Member of "Domain"
* Adjust to yourname.local.

## CA

* The network adapter needs to be set to the MGMT network
* Now we need to use nmtui to configure network settings
* DNS needs to be set to the new Domain Controller
* Change hostname to ca-yourname 
* Reboot.