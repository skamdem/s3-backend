# Terraform remote backend (AWS) 

> This project shows how to setup a remote backend in AWS:


- **S3 Bucket** is used for *storage*
- **DynamoDB** is used for *locking*
***
## List of commands:

```
$ terraform init
$ terraform validate
$ terraform fmt
$ terraform plan
$ terraform apply
$ terraform init -upgrade // after updating "required_providers"
$ terraform destroy // cleanup on project completion"
```
***
## Files configuration : 

| Fine name | Contents |
| ------------ | ------------- |
| aws_resources.tf | resources |
| main.tf | terraform setup |
| outputs.tf | outputs |
| providers.tf | list of providers |
| terraform.tfvars | actual values of variable |
| variables.tf | variables definition |
