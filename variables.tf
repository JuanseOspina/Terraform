variable "MY_ACCESS_KEY" {}
variable "MY_SECRET_KEY" {}
#------------------------Networking---------------------#
variable "VPC_CIDR_BLOCK" {}
variable "CIDR_SUBNET_PUBLIC_1"{}
variable "ZONE_SUBNET_PUBLIC_1"{}

variable "CIDR_SUBNET_PUBLIC_2"{}
variable "ZONE_SUBNET_PUBLIC_2"{}

variable "CIDR_SUBNET_PRIVATE_1"{}
variable "ZONE_SUBNET_PRIVATE_1"{}

variable "CIDR_SUBNET_PRIVATE_2"{}
variable "ZONE_SUBNET_PRIVATE_2"{}

variable "CIDR_SUBNET_DB_1" {}
variable "ZONE_SUBNET_DB_1"{}

variable "CIDR_SUBNET_DB_2" {}
variable "ZONE_SUBNET_DB_2"{}
#------------------------Security-Groups-----------------#
variable "ingress_bastion_rule" {}
variable "ingress_master_rule_1" {}
variable "ingress_master_rule_2" {}
variable "ingress_node_rule" {}

variable "bucket_name" {}
variable "bucket_tags" {}
variable "bucket_acl" {}

variable "DB_user" {}
variable "DB_password" {}
