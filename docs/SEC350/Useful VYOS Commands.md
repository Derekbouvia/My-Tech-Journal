# Useful VYOS commands

**Enter configure mode:**

`configure`

**Change Password: **

 `set system login user [username] authentication plaintext-password [password]`

**Change hostname:** 

`set system host-name < hostname >`

**View interfaces:** 

`show interfaces`

**Remove DHCP config:** 

`delete interfaces ethernet <interface_name> address dhcp`

**Set static ip:** 

`set interfaces ethernet <interface_name> address <ip/cidr>`

**Set description on interface:**

`set interfaces ethernet <interface_name> description < description >`

**Set static route:** 

`set protocols static route 0.0.0.0/0 next-hop < next-hop >`

**Set name server:** `set system name-server < ip of name server >`