### Create docker user

sudo usermod -aG docker $USER

### Then apply the group change
newgrp docker
