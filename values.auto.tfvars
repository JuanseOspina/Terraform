MY_ACCESS_KEY = "-"
MY_SECRET_KEY = "-"
#----------------------Networking--------------------------#
VPC_CIDR_BLOCK = "10.0.0.0/24"
CIDR_SUBNET_PUBLIC_1 = "10.0.0.0/27"
ZONE_SUBNET_PUBLIC_1 = "us-east-1a"

CIDR_SUBNET_PUBLIC_2 = "10.0.0.32/27"
ZONE_SUBNET_PUBLIC_2 = "us-east-1b"

CIDR_SUBNET_PRIVATE_1 = "10.0.0.64/27"
ZONE_SUBNET_PRIVATE_1 = "us-east-1a"

CIDR_SUBNET_PRIVATE_2 = "10.0.0.96/27"
ZONE_SUBNET_PRIVATE_2 = "us-east-1b"

CIDR_SUBNET_DB_1 = "10.0.0.128/27"
ZONE_SUBNET_DB_1 = "us-east-1a"

CIDR_SUBNET_DB_2 = "10.0.0.160/27"
ZONE_SUBNET_DB_2 = "us-east-1b"

#-----------------------Bucket-------------------------------#
bucket_name = "bucket-JuOspina"

bucket_tags = {
    Name="juospina-bucket",
    CreateBy="JuOspina"
    }
bucket_acl = "private"

#-----------------------APP-----------------------------------#
DB_user = "admin"
DB_password = "J680o680#"
