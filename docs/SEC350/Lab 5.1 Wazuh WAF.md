# Lab Summary

In This lab we added a web application firewall to web01 adn then we tested it

## Adding software to web01

Since updating web01 requires connecting the internet through WAN we have to add a couple firewall rules . One is a permanent rule and the other is temporary.

## WAN-to-DMZ

On fw01 there needs to be a permanent rule that allows connections back through WAN-to-DMZ firewall.

First we can check to see if the rule already exists with command below

`show firewall name WAN-to-DMZ`

If it doesnt exist we can add it by running the following commands 

`configure`

`set firewall name WAN-to-DMZ rule 1 action accept`

`set firewall name WAN-to-DMZ rule 1 state established`

`commit`

`save`

## DMZ-to-WAN

Since the permanent rule has been added we also have to add a temporary rule to allow traffic through (but only while we update) by running the commands below

`configure`

`set firewall name DMZ-to-WAN rule 999 action accept`

Now we need to set the source address to the web server by running the commands below

`set frewall name DMZ-to-WAN rule 999 source address 172.16.50.3`

`commit`

**One thing we can do is make sure that we dont save the rule since its only temporary. We can keep it committed until after we run the update and that way its just in memory and not persistent on the reboot**

## Adding and testing mod_security

To install the necessary services  such as mod_security and php to make a webshell work we must run the following command below

`sudo yum install mod_security mod_security_crs install php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysqlnd -y`

Then we must restart  https to apply changes

`sudo systemctl restart httpd`

check to see if mod_security was installed 

`sudo httpd -M | grep security2`

We can also check by navigating as root to **/var/log**

and entering 

`cat error_log | grep ModSecurity`

## Testing ModSecurity

If we try to currently navigate to the webserver (in this case index.html) we will get a 403 forbidden  error.  We can test this by navigating to **/var/log** and enter the command below to check the error

`cat error_log | grep 960017`

Now we need to tell ModSecurity to  allow access to web01 via an IP address. This is done by editing the **/etc/httpd/conf.d/mod_security.conf** file. Rule 960017 is the associated rule that prevented access which was an error message shown above. Underneath

**Default recommended configuration**

**SecRuleEngine On**

We need to include 

`<locationmatch "/"`

   `SecRuleRemoveById 960017`

`</locationmatch>`

**SecRequestBodyAccess on**

Now we need to restart httpd again after saving the file we should be able to curl the webserver from the WAN on **rw01** by typing

`curl http://172.16.50.3`

and it should 

