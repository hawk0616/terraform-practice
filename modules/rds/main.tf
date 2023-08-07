resource "aws_db_instance" "main" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "user"
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids = [module.security_groups.rds_sg.id]
}

resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = [aws_subnet.private_subnet_1a.id, aws_subnet.private_subnet_1b.id, aws_subnet.private_subnet_2a.id, aws_subnet.private_subnet_2b.id]

  tags = {
    Name = "main"
  }
}
