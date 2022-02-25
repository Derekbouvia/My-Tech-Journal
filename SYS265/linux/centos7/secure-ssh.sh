#secure-ssh.sh
#author Derekbouvia
#creates a new ssh user using $1 parameter
#adds a public key from the local repo or curled from the remote repo
user=$1 #user takes a command line argument
sudo useradd -m -d /home/$user -s /bin/bash $user # adding a user to home directory
sudo mkdir /home/$user/.ssh
sudo cp /home/Derekbouvia/My-Tech-Journal/SYS265/linux/public-keys/id_rsa.pub /home/$user/.ssh/authorized_keys
sudo chmod 700 /home/$user/.ssh
sudo chmod 600 /home/$user/.ssh/authorized_keys
sudo chown -R $user:$user /home/$user/.ssh
