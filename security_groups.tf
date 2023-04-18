#-----------------------SG-Bastion-----------------------#

resource "aws_security_group" "JuOspina-SG-Bastion" {
    name = "JuOspina-SG-Bastion"
    description = "Allow ssh to private instances"
    vpc_id = aws_vpc.JuOspina-VPC.id

    dynamic "ingress" {
        for_each = var.ingress_bastion_rule
        content {
          from_port        = ingress.value.from_port
          to_port          = ingress.value.to_port
          protocol         = ingress.value.protocol
          cidr_blocks      = ingress.value.cidr_blocks
        }
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "JuOspina-SG-Bastion"
    }
}

#--------------------------------SG-Nodes---------------------------------#

resource "aws_security_group" "JuOspina-SG-Nodes" {
    name = "JuOspina-SG-Node"
    description = "Allow ssh only from bastion, and K8S ports"
    vpc_id = aws_vpc.JuOspina-VPC.id

    dynamic "ingress" {
        for_each = var.ingress_node_rule
        content {
          from_port        = ingress.value.from_port
          to_port          = ingress.value.to_port
          protocol         = ingress.value.protocol
          cidr_blocks      = ingress.value.cidr
        }
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "JuOspina-SG-Nodes"
    }
}

#---------------------------------SG-Master-------------------------------#

resource "aws_security_group" "JuOspina-SG-Master" {
    name = "JuOspina-SG-Master"
    description = "Allow ssh connection and K8S ports"
    vpc_id = aws_vpc.JuOspina-VPC.id

    dynamic "ingress" {
        for_each = var.ingress_master_rule_1
        content {
          from_port        = ingress.value.from_port
          to_port          = ingress.value.to_port
          protocol         = ingress.value.protocol
          security_groups =  ["${aws_security_group.JuOspina-SG-Nodes.id}"] 
        }
    }

    dynamic "ingress" {
        for_each = var.ingress_master_rule_2
        content {
          from_port        = ingress.value.from_port
          to_port          = ingress.value.to_port
          protocol         = ingress.value.protocol
          security_groups =  ["${aws_security_group.JuOspina-SG-Bastion.id}"] 
        }
    }


    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    
    tags = {
        Name = "JuOspina-SG-Master"
    }
}

#---------------------------------SG-DB-------------------------------#
resource "aws_security_group" "JuOspina-SG-DB" {
    name = "JuOspina-SG-DB"
    description = "Allow connection from mysql ports"
    vpc_id = aws_vpc.JuOspina-VPC.id

    ingress {
        from_port        = 3306
        to_port          = 3306
        protocol         = "tcp"
        cidr_blocks      = ["10.0.0.0/24"]
        ipv6_cidr_blocks = ["::/0"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    
    tags = {
        Name = "JuOspina-SG-Master"
    }
  
}

resource "aws_security_group" "JuOspina-LB-SG" {
    name = "JuOspina-LB-SB"
    description = "Allow connection from mysql ports"
    vpc_id = aws_vpc.JuOspina-VPC.id

    ingress {
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    egress {
        from_port        = 30001
        to_port          = 30001
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    
    tags = {
        Name = "JuOspina-SG-Master"
    }
}