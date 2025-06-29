### Create docker user

sudo usermod -aG docker $USER

### Then apply the group change
newgrp docker


### change docker name(tag)
docker tag 9045fc5075d1 my-apache:fixed

### Stop all running containers:
docker stop $(docker ps -q)

Stop a specific container:
docker ps ##Find the container ID or name:
 


## Remove an image by ID
docker rmi 9045fc5075d1


## Check if a port is listening
sudo lsof -i -P -n | grep LISTEN
netstat -tuln | grep :8000

## Check firewall rules
sudo ufw status
sudo firewall-cmd --list-all

## DOCKER CONTAINER  Check published ports
docker ps
