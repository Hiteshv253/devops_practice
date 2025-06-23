run for each environment

Deploy to dev:

bash Copy Edit
terraform init
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"

Deploy to stage:

bash Copy Edit
terraform plan -var-file="stage.tfvars"
terraform apply -var-file="stage.tfvars"


Deploy to prod:

bash Copy Edit
terraform plan -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars"



store out put in text file
terraform output > instance_ips.txt

ls -la ~/.ssh/id_rsa
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa

