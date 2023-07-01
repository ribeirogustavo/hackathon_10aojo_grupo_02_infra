provider "aws" {  
  region = "us-east-1"  
}  
  
resource "aws_vpc" "vpc" {  
  cidr_block = "10.0.0.0/16"  
}  
  
resource "aws_subnet" "subnet" {  
  count = 3  
  
  cidr_block = "10.0.${count.index}.0/24"  
  availability_zone = "us-east-1a"  
  vpc_id = aws_vpc.vpc.id  
}  
  
resource "aws_db_subnet_group" "db_subnet_group" {  
  name       = "db_subnet_group"  
  subnet_ids = aws_subnet.subnet.*.id  
}  
  
resource "aws_security_group" "db_security_group" {  
  name_prefix = "db_security_group"  
  
  ingress {  
    from_port = 0  
    to_port = 3306  
    protocol = "tcp"  
    cidr_blocks = ["0.0.0.0/0"]  
  }  
}  
  
resource "aws_db_instance" "db_instance" {  
  identifier             = "db_instance"  
  engine                 = "mysql"  
  engine_version         = "5.7"  
  instance_class         = "db.t2.micro"  
  allocated_storage      = 5  
  name                   = "hackathon"  
  username               = var.db_username  
  password               = var.db_password  
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name  
  vpc_security_group_ids = [aws_security_group.db_security_group.id]  
}  
