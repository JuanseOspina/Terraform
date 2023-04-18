output "RDS_endpoint" {
    value = aws_db_instance.JuOspina-DB.endpoint
}

output "load-balancer" {
    value = aws_alb.JuOspina-LB.dns_name
}

output "public_ips" {
    value = {
        Bastion_public= aws_instance.Bastion.public_ip
        Node01_public = aws_instance.Node_01.public_ip
        Node02_public = aws_instance.Node_02.public_ip
    }
}

output "instance_ips" {
    value = {
        Master  = aws_instance.Master.private_ip
        Node_01 = aws_instance.Node_01.private_ip
        Node_02 = aws_instance.Node_02.private_ip 
    }
}

resource "local_file" "IP_Outputs" {
    content = <<EOF
    ${aws_instance.Master.private_ip}
    ${aws_instance.Node_01.private_ip}
    ${aws_instance.Node_02.private_ip}
    EOF
    filename = "${path.module}/documents/test_ip.txt"
}

