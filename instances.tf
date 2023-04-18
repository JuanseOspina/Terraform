resource "aws_instance" "Bastion" {
    ami = "ami-0557a15b87f6559cf"
    instance_type = "t2.medium" 
    subnet_id = aws_subnet.JuOspina-Public-1.id

    vpc_security_group_ids = [aws_security_group.JuOspina-SG-Bastion.id]
    key_name = "JuOspina_key"

    associate_public_ip_address = true

    tags = {
      "Name" = "JuOspina-Bastion"
    }

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("/mnt/c/Users/juospina/JuOspina/Rampup/Terraform/documents/JuOspina_key.pem")
      host = self.public_ip
    }

    provisioner "file" {
      source = "/mnt/c/Users/juospina/JuOspina/Rampup/Terraform/documents"
      destination = "/home/ubuntu"
    }

    provisioner "remote-exec" {
      inline = [
        "sudo apt-get update -y",
        "sudo apt-get install -y software-properties-common",
        "sudo apt-add-repository -y ppa:ansible/ansible",
        "sudo apt-get update -y",
        "sudo apt-get install -y ansible",
        "chmod +x documents/script.sh",
        "chmod 400 documents/JuOspina_key.pem",
        "./documents/script.sh"
      ]
    }

    depends_on = [local_file.IP_Outputs]
}

resource "aws_instance" "Master" {
    ami = "ami-0557a15b87f6559cf"
    instance_type = "t2.medium" 
    subnet_id = aws_subnet.JuOspina-Private-1.id

    vpc_security_group_ids = [aws_security_group.JuOspina-SG-Master.id]
    key_name = "JuOspina_key"

    associate_public_ip_address = false

    tags = {
      "Name" = "JuOspina-Master"
    }
}

resource "aws_instance" "Node_01" {
    ami = "ami-0557a15b87f6559cf"
    instance_type = "t2.medium" 
    subnet_id = aws_subnet.JuOspina-Public-1.id

    vpc_security_group_ids = [aws_security_group.JuOspina-SG-Nodes.id]
    key_name = "JuOspina_key"

    associate_public_ip_address = true

    tags = {
      "Name" = "JuOspina_Node01"
    }
}

resource "aws_instance" "Node_02" {
    ami = "ami-0557a15b87f6559cf"
    instance_type = "t2.medium" 
    subnet_id = aws_subnet.JuOspina-Public-2.id

    vpc_security_group_ids = [aws_security_group.JuOspina-SG-Nodes.id]
    key_name = "JuOspina_key"

    associate_public_ip_address = true

    tags = {
      "Name" = "JuOspina_Node02"
    }
}