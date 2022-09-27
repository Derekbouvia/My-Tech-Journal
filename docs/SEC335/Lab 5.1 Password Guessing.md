# Cewl (The custom wordlist generator crawls websites to create custom wordlists.

In this lab we used cewl to create custom wordlist for the shire bio pages of Frodo Pippin Bilbo and Samwise from the bios page on http://10.0.5.21/bios
 
 `-d` is the depth to spider to the default is 2
 
 To use cewl to create a cutome wordlist for a bio page of frodo and put into a text file i used the command below
 
 `cewl -d 1 http://10.0.5.21/bios/frodo -w frodo.txt`
 
 
 
