# Reflection

This week we have gone over the foundation of ethical hacking as well as talked about passive recon and methods that can be used to do so. We have been introduced to our environment as well as become familiar with the "Rules of engagement"

# Passive Recon

* Gathering information that is readily available to the public to obtain intelligence to a specific target this is also known as (OSINT) which means open source intelligence.



# Methods

* **Google Hacking:** aka "dorking" which uses search engine to execute a more specific search [Exploit Database](https://www.exploit-db.com/google-hacking-database)
* **Shodan:** Internet of things Search Engine where you can find out what services are running or devices used just by an IP address. There are filters to find routers, ftp servers etc. There is also anonymity with this tool. [Shodan](https://www.shodan.io/)
* **TheHarvester:** This method come preinstalled on Kali [TheHarvester](https://www.kali.org/tools/theharvester/) A command line utility that queries multiple search engines at one time
* **Metagoofil:** Another Command line utility that utilizes passive recon and is used to perform metadata analysis of public files [Metagoofil](https://www.kali.org/tools/metagoofil/)
* **Whois:** Command line utility known as whois Access to domain owner or organization information lots of personal information can be found like addresses, email, phone numbers etc. [ICANN LOOKUP](https://lookup.icann.org/en)

# Kali Setup

Instead of VPN we will be accessing our Kali system with Google remote desktop so that we can attack target networks. Once at the google remote desktop site it needs to be downloaded and add user account (avoid using school or personal account)



# Google Remote Desktop

[Google Remote Desktop](remotedesktop.google.come/access)

Once linked its time to configure the virtual machine using wireguard, a VPN solution.

# Wireguard 

- First run the command

  **Sudo apt install wireguard -y**

- Once installed copy the provided wireguard config file to /etc/wireguard

- Now run command 

  **sudo wg-quick up wg0**

  to create interface and set up connection
