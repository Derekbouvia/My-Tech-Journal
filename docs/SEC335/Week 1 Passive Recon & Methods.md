# Reflection

This week we have gone over the foundation of ethical hacking as well as setting up our environments. This week we also talked about the rules of ethical hacking as well as passive recon and methods that can be used to do so. (See below) 

# Passive Recon

* Gathering information that is readily available to the public to obtain intelligence to a specific target this is also known as (OSINT) which means open source intelligence. The following items are included in passive recon.

* **Google Hacking:** aka "dorking" which uses search engine to execute a more specific search [Exploit Database](https://www.exploit-db.com/google-hacking-database)
* **Shodan:** Internet of things Search Engine where you can find out what services are running or devices used just by an IP address. There are filters to find routers, ftp servers etc. There is also anonymity with this tool. [Shodan](https://www.shodan.io/)
* **Netcraft:** This is a company that provides cybercrime disruption services. You can use their site to obtain technical reports on other websites.
* **TheHarvester:** This method come preinstalled on Kali [TheHarvester](https://www.kali.org/tools/theharvester/) A command line utility that queries multiple search engines at one time
* **Metagoofil:** Another Command line utility that utilizes passive recon and is used to perform metadata analysis of public files [Metagoofil](https://www.kali.org/tools/metagoofil/)
* **IP Address Registration: ** Similar to domain registrations you can look up the owner of an IP address. You can use DNS Check [DNS Checker](https://dnschecker.org/ip-whois-lookup.php) online to get a lot of information on the organization that own the IP address space.
* **Whois:** Command line utility known as whois Access to domain owner or organization information lots of personal information can be found like addresses, email, phone numbers etc. [ICANN LOOKUP](https://lookup.icann.org/en)

# Kali Setup

Instead of VPN we will be accessing our Kali system with Google remote desktop so that we can attack target networks. Once at the google remote desktop site it needs to be downloaded and add user account (avoid using school or personal account)



# Google Remote Desktop

[Google Remote Desktop](https://remotedesktop.google.com/access)

Once linked its time to configure the virtual machine using wireguard, a VPN solution.

# Wireguard 

- First run the command

  **Sudo apt install wireguard -y**

- Once installed copy the provided wireguard config file to /etc/wireguard

- Now run command 

  **sudo wg-quick up wg0**

  to create interface and set up connection
