# 1. VPC variables
variable "vpc_cidr_block" {
  description = "CIDR Block of VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "main"
}

# 2. Subnet variables
variable "subnet_cidr_block" {
  description = "CIDR Block of Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnt_name" {
  description = "Name of VPC"
  type        = string
  default     = "public"
}

# 3. Instance variables
variable "instance_name" {
  description = "The Name for EC2 instance"
  type        = string
  default     = "my_instance"
}