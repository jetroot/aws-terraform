## About
Provision infrastructure using terraform for AWS Cloud

## Install
1. Install terraform
2. Install aws cli
3. Get your access & secret keys from Aws

2. Run aws configure
``` bash
    aws configure
```

## Configure
1. Initialize terraform
``` bash
    terraform init
```

2. Check what will happen
``` bash
    terraform plan
```

3. Create resources
``` bash
    terraform apply
```

## Running
1. Go to instances in aws
2. Copy IP4
3. Paste it in the browser 

## Shutdown 
=> Don't forget to shutdown your resources
``` bash
    terraform destroy
```