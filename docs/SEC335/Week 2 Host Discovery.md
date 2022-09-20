## Reflection 

Working on scripts has been challenging for me but it has been interesting to see how easy it is to get simple tools to get information. I struggled with the syntax at first but after a while it started to make more sense.

## Host Discovery

We looked at scanning hosts to see if they were up using three command line utilities which were ping, fping and nmap. Below are examples of the scripts I made for each to complete the assignments in the lab.

## Ping

I used the bash script called pingsweep to ping ip's in the range of 10.0.5.2 - 10.0.5.50 which outputs a list of up ip addresses into a file called sweep.txt

```#!/bin/bash
#!/bin/bash
for ip in $(seq 2 50); do
ping -c 1 10.0.5.$ip | grep "bytes from" | awk '{print $4}' | cut -d ":" -f 1 done
```

i then ran the command

`./pingsweep > sweep.txt`

## Fping 

I then tried to do the same thing with fping with this line

`sudo fping -g 10.0.5.2 10.0.5.50 -a 1> sweep2.txt`

## Nmap

I finally used Nmap which seemed like the best approach for conducting a scan. I sent the results of the Nmap scan to grep to see if the host is up and then that information is sent to awk so the ip address is removed and sent to sweep3.txt and below ive shown the code that I used to do so.

`nmap -sn -n --vv 10.0.5.2-50 | grep -B 1 "Host is up" | awk '/Nmap/{print $5}' >> sweep3.txt`





