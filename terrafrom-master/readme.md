terraform fmt          # Format .tf files
terraform validate     # Check syntax correctness
terraform plan         # Dry run (no changes yet)
terraform apply        # Actually apply if plan is good

=========================
# Basic dry run
terraform plan

# With variables file
terraform plan -var-file="terraform.tfvars"

# With a specific plan output
terraform plan -out=tfplan

# Show in detail
terraform plan -detailed-exitcode


======================
##summary
Command	Purpose
terraform plan	Dry run: see what changes will be made
terraform apply	Actually make the changes
terraform destroy	Remove resources