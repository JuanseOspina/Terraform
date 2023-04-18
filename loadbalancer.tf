resource "aws_alb_target_group" "JuOspina-Target" {
    name = "juospina-tg"
    port = 30001
    protocol = "HTTP"
    vpc_id = aws_vpc.JuOspina-VPC.id
}

resource "aws_alb_target_group_attachment" "JuOspina-Target-attachment-1" {
    target_group_arn = aws_alb_target_group.JuOspina-Target.arn
    target_id = aws_instance.Node_01.id
    port = 30001
}

resource "aws_alb_target_group_attachment" "JuOspina-Target-attachment-2" {
    target_group_arn = aws_alb_target_group.JuOspina-Target.arn
    target_id = aws_instance.Node_02.id
    port = 30001
}

resource "aws_alb" "JuOspina-LB" {
    name = "juospina-lb"
    internal = false
    load_balancer_type = "application"
    subnets = [aws_subnet.JuOspina-Public-1.id,aws_subnet.JuOspina-Public-2.id]
    security_groups = [aws_security_group.JuOspina-LB-SG.id]   
 
}

resource "aws_alb_listener" "JuOspina-LB-listener" {
    load_balancer_arn = aws_alb.JuOspina-LB.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_alb_target_group.JuOspina-Target.arn
    }
  
}