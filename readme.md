## About
Provision infrastructure using terraform for AWS Cloud

## Install
1. Install terraform
2. Install aws cli
3. Get your access & secret keys from AWS
4. Run aws configure
``` bash
    aws configure
```

## Configure
1. Initializes a working directory containing Terraform configuration files. 
``` bash
    terraform init
```

2. preview the changes that Terraform plans to make to the infrastructure
``` bash
    terraform plan
```

3. Create resources
``` bash
    terraform apply
```

## Running
1. Go to instances in `AWS` console
2. Copy IP4
3. Paste it in the browser 

## Shut down 
=> Don't forget to shut down your resources
``` bash
    terraform destroy
```