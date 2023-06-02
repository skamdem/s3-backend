# Terraform remote backend (AWS) 

This project shows how to setup a remote backend in AWS 
S3 Bucket is used for storage
DynamoDB is used for locking

We shall be running the following commands:

```
$ terraform init
$ terraform validate
$ terraform fmt
$ terraform plan
$ terraform apply
```
Note: Run this if you update "required_providers"
```
terraform init -upgrade
```

for delete:
```
$ terraform destroy
```
Files are organized as follows:

aws_resources.tf -> resources

providers.tf -> list of providers

main.tf -> terraform setup

outputs.tf -> outputs

variables.tf -> variables definition

terraform.tfvars -> actual values of variable