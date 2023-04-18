resource "aws_vpc" "JuOspina-VPC" {
    cidr_block = var.VPC_CIDR_BLOCK
    tags = {
        Name="JuOspina-VPC"
    }
}

#-----------------------------PUBLIC--------------------------------#
#CREATE SUBNETS
resource "aws_subnet" "JuOspina-Public-1" {
    vpc_id = aws_vpc.JuOspina-VPC.id
    cidr_block = var.CIDR_SUBNET_PUBLIC_1
    availability_zone = var.ZONE_SUBNET_PUBLIC_1

    tags = {
        Name = "JuOspina-Public-1"
    }
}

resource "aws_subnet" "JuOspina-Public-2" {
    vpc_id = aws_vpc.JuOspina-VPC.id
    cidr_block = var.CIDR_SUBNET_PUBLIC_2
    availability_zone = var.ZONE_SUBNET_PUBLIC_2
    
    tags = {
        Name = "JuOspina-Public-2"
    }
}

#CREATE INTERNET GATEWAY
resource "aws_internet_gateway" "JuOspina-IG" {
    vpc_id = aws_vpc.JuOspina-VPC.id

    tags = {
        Name = "JuOspina-IG"
    }
  
}

#CREATE ROUTE TABLE
resource "aws_route_table" "JuOspina-RT-Public" {
    vpc_id = aws_vpc.JuOspina-VPC.id

    tags = {
        Name = "JuOspina-RT-Public"
    }
  
}

#ASSOCIATE INTERNET GATEWAY WITH ROUTE TABLE
resource "aws_route" "route_IG" {
    route_table_id = aws_route_table.JuOspina-RT-Public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.JuOspina-IG.id  
}

#ASSOCIATE SUBNETS WITH ROUTE TABLE
resource "aws_route_table_association" "Association_Public_1" {
  subnet_id = aws_subnet.JuOspina-Public-1.id
  route_table_id = aws_route_table.JuOspina-RT-Public.id
}

resource "aws_route_table_association" "Association_Public_2" {
  subnet_id = aws_subnet.JuOspina-Public-2.id
  route_table_id = aws_route_table.JuOspina-RT-Public.id
}

#-----------------------------PRIVATE--------------------------------#

#CREATE PRIVATE SUBNETS
resource "aws_subnet" "JuOspina-Private-1" {
    vpc_id = aws_vpc.JuOspina-VPC.id
    cidr_block = var.CIDR_SUBNET_PRIVATE_1
    availability_zone = var.ZONE_SUBNET_PRIVATE_1

    tags = {
        Name = "JuOspina-Private-1"
    }
}

resource "aws_subnet" "JuOspina-Private-2" {
    vpc_id = aws_vpc.JuOspina-VPC.id
    cidr_block = var.CIDR_SUBNET_PRIVATE_2
    availability_zone = var.ZONE_SUBNET_PRIVATE_2
    
    tags = {
        Name = "JuOspina-Private-2"
    }
}

#CREATE NAT GATEWAY (ELASTIC IP)
resource "aws_eip" "JuOspina-eip-nat" {
    vpc = true

}

resource "aws_nat_gateway" "JuOspina_NAT" {
  allocation_id = aws_eip.JuOspina-eip-nat.id
  subnet_id = aws_subnet.JuOspina-Public-1.id

}

#CREATE ROUTE TABLE
resource "aws_route_table" "JuOspina-RT-Private" {
    vpc_id = aws_vpc.JuOspina-VPC.id

    tags = {
        Name = "JuOspina-RT-Private"
    }
  
}

#ASSOCIATE NAT GATEWAY WITH ROUTE TABLE
resource "aws_route" "ruta_nat_gateway" {
  route_table_id         = aws_route_table.JuOspina-RT-Private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.JuOspina_NAT.id
}

#ASSOCIATE SUBNETS WITH ROUTE TABLES
resource "aws_route_table_association" "Association_Private_1" {
  subnet_id = aws_subnet.JuOspina-Private-1.id
  route_table_id = aws_route_table.JuOspina-RT-Private.id
}

resource "aws_route_table_association" "Association_Private_2" {
  subnet_id = aws_subnet.JuOspina-Private-2.id
  route_table_id = aws_route_table.JuOspina-RT-Private.id
}

#-----------------------------RDS--------------------------------#

resource "aws_subnet" "JuOspina-RDS-Subnet-1" {
    vpc_id = aws_vpc.JuOspina-VPC.id
    cidr_block = var.CIDR_SUBNET_DB_1
    availability_zone = var.ZONE_SUBNET_DB_1

    tags = {
        Name = "JuOspina-RDS-Subnet-1"
    }
}

resource "aws_subnet" "JuOspina-RDS-Subnet-2" {
    vpc_id = aws_vpc.JuOspina-VPC.id
    cidr_block = var.CIDR_SUBNET_DB_2
    availability_zone = var.ZONE_SUBNET_DB_2

    tags = {
        Name = "JuOspina-RDS-Subnet-2"
    }
}