resource "aws_db_subnet_group" "JuOspina-DB-SubnetGroup" {
  name = "juospina-rds-subnets"
  subnet_ids = [aws_subnet.JuOspina-RDS-Subnet-1.id,aws_subnet.JuOspina-RDS-Subnet-2.id]
  
}
resource "aws_db_instance" "JuOspina-DB" {
  engine = "mysql"
  engine_version = "8.0.32"
  allocated_storage = 20
  storage_type = "gp2"
  instance_class = "db.t3.micro"

  identifier = "juospina-db"
  username = var.DB_user
  password = var.DB_password

  publicly_accessible = false
  skip_final_snapshot = true

  parameter_group_name = "default.mysql8.0"
  db_subnet_group_name = aws_db_subnet_group.JuOspina-DB-SubnetGroup.name
  vpc_security_group_ids = [aws_security_group.JuOspina-SG-DB.id]

  tags = {
    Name = "juospina-db"
  }
  
}