# variables.tf

# <<<<< EKSCTL MY EC2 >>>>>
variable "cluster_base_name" {
  description = "Must be a valid Allowed Pattern '[a-zA-Z][-a-zA-Z0-9]*'"
  type        = string
  default     = "myeks"

  validation {
    condition     = can(regex("^[a-zA-Z][-a-zA-Z0-9]*$", var.cluster_base_name))
    error_message = "cluster_base_name must match the pattern [a-zA-Z][-a-zA-Z0-9]*"
  }
}

variable "key_name" {
  description = "Name of an existing EC2 KeyPair to enable SSH access to the instances."
  type        = string
  sensitive   = true
}

variable "sg_ingress_ssh_cidr" {
  description = "The IP address range that can be used to communicate to the EC2 instances."
  type        = string
  default     = "0.0.0.0/0"
}

variable "my_instance_type" {
  description = "Enter t2.micro, t2.small, t2.medium, t3.micro, t3.small, t3.medium. Default is t3.medium."
  type        = string
  default     = "t3.medium"

  validation {
    condition = contains(
      ["t2.micro", "t2.small", "t2.medium", "t3.micro", "t3.small", "t3.medium"],
      var.my_instance_type
    )
    error_message = "my_instance_type must be one of: t2.micro, t2.small, t2.medium, t3.micro, t3.small, t3.medium."
  }
}

variable "latest_ami_id" {
  description = "(DO NOT CHANGE)"
  type        = string
  default     = "ami-0ee82191e264e07cc"

  validation {
    condition     = var.latest_ami_id == "ami-0ee82191e264e07cc"
    error_message = "ami-0ee82191e264e07cc'."
  }
}

# <<<<< Region AZ >>>>>
variable "target_region" {
  description = "AWS Region to deploy resources."
  type        = string
  default     = "ap-northeast-2"
}

variable "availability_zone1" {
  description = "First Availability Zone."
  type        = string
  default     = "ap-northeast-2a"
}

variable "availability_zone2" {
  description = "Second Availability Zone."
  type        = string
  default     = "ap-northeast-2c"
}

# <<<<< VPC Subnet >>>>>
variable "vpc_block" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "192.168.0.0/16"
}

variable "public_subnet1_block" {
  description = "CIDR block for the first public subnet."
  type        = string
  default     = "192.168.1.0/24"
}

variable "public_subnet2_block" {
  description = "CIDR block for the second public subnet."
  type        = string
  default     = "192.168.2.0/24"
}

variable "private_subnet1_block" {
  description = "CIDR block for the first private subnet."
  type        = string
  default     = "192.168.3.0/24"
}

variable "private_subnet2_block" {
  description = "CIDR block for the second private subnet."
  type        = string
  default     = "192.168.4.0/24"
}
