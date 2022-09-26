# Install Wazuh
## Hardwire 

Before doing any installation change the log01 network to lan

Then changre log01 IP using nmtui to 172.16.150.5

For single node installation run command 
 
 `curl -sO https"://packages.wazuh.com/4.3/wazuh-install.sh && sudo bash ./wazuh-install.sh -a`

IMPORTANT - After receiving user name and password make sure to jot down password and do not lose it!

  ## Now we must open up the ports 
  
  In this case we are needing to open up  the following ports 
  1515/tcp
  1514/tcp
  514/tcp
  514/udp
  55000/tcp
  443/tcp
  so we need to run the following commands
  
  `firewall-cmd --permanent --add-port=1515/tcp,1514/tcp,514/tcp,514/udp,55000/tcp,443/tcp`
 
 `firewall-cmd --reload`
 
 To ensure the following ports are open run command
 
 `firewall-cmd --list-ports`
 
 ## Configure the web01 system to point to the new IP
 
 Use the following commands in vyos
 
 `configure`
 
 `set system syslog host 172.16.150.5 facility authpriv level info`
 
 `commit`
 
 `save`
 
 On web01 restart syslog with command
 
 `sudo systemctl restart rsyslog`
 
 Change the vyos syslog to point to new IP by using this command
 
 cat /etc/rsyslog.d/sec350.conf
 
 edit file to have 150.5 instead of 50.5
 
 edit agent to specified configs
 
The conf file is the main configuration file on the Wazuh Manager and it plays an important role on the agents.

* This file can be found at /var/ossec/etc/ossec.conf
