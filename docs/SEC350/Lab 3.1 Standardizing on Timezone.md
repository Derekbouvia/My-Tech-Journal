# Lab Summary

In this lab we are synchronizing time zones of active VMs so that the logging we do is consistent among them and will allow for easier building of timeline events.

## Commands 

### Adding time zones to logs in Ubuntu Linux Boxes 

As of now if `date` is entered it will return the date and time of the machine

We can test if timestamps are being included by running the command below

`logger -t test whattimeisit`

to check the test run command below

`sudo cat /var/log/syslog | grep whattimeisit`

when the time appears there will be no time zone so we must change the configuration in the rsyslog.conf file by running the command below

`sudo vi /etc/rsyslog.conf`

Now that we are in the file we must comment out the line that reads

`$ActionFileDefaultTemplate #RSYSLOG_TraditionalFileFormat`

Now we must save and exit out of the config using command below

`:wq!` 

and then restart rsyslog to apply changes using command below

`systemctl restart rsyslog`

If the command from up above is run again it will now show the time zone attached to the log.

### Adding Time Zones to Logs in CentOS Linux Boxes like log01 or web01

Again we need to open the syslog config file with the command below

`sudo vi /etc/rsyslog.conf`

Again we need to comment out the same line in the config file as we did before and then restart using the command below

`systemctl restart rsyslog`

Logger is used in the same way. The command to check for logs in CentOS is the command below

`sudo tail /var/log/messages`



