###install ansible using this code

sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible

###openssh-server
sudo apt install openssh-server -y

##check connection of salve node
ssh aws@ip 
telnet ipaddress port
ping ip-address

###check ips ping for connnection of salve machin(node machin)
ansible -i inventory.txt webservers -m ping

###
ssh-keyscan 192.168.190.166 >> ~/.ssh/known_hosts
ssh-keyscan 192.168.190.167 >> ~/.ssh/known_hosts

ls -ld  ~/.ssh/known_hosts ## for show yout finger keys


##run time to ask password
ansible-playbook -i inventory.txt main.yml --ask-become-pass

ansible all -i inventory.ini -m ping --ask-pass


### for external script call make sure to permission
chmod +x install.sh


###install ansible using this code

sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible

###openssh-server
sudo apt install openssh-server -y

##check connection of salve node
ssh aws@ip 
telnet ipaddress port
ping ip-address

###check ips ping for connnection of salve machin(node machin)
ansible -i inventory.txt webservers -m ping

###
ssh-keyscan 192.168.190.166 >> ~/.ssh/known_hosts
ssh-keyscan 192.168.190.167 >> ~/.ssh/known_hosts

ls -ld  ~/.ssh/known_hosts ## for show yout finger keys


###run time to ask password
ansible-playbook -i inventory.txt main.yml --ask-become-pass

ansible all -i inventory.ini -m ping --ask-pass


### Create SSH key in local
ssh-keygen -t rsa -b 4096 -f ~/.ssh/node_key
ssh-copy-id -i ~/.ssh/node_key.pub ubuntu@192.168.190.50
[app]
192.168.190.50 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/node_key ansible_become=true



