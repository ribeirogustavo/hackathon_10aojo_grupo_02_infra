
provider "aws" {  
  region = "us-east-1"  
}  
  
resource "aws_subnet" "my_subnet" {  
  vpc_id     = "vpc-12345678"  
  cidr_block = "10.0.1.0/24"  
  availability_zone = "us-east-1a"  
  tags = {  
    Name = "my-subnet"  
  }  
}  
provider "aws" {  
  region = "us-east-1"  
}  
  
resource "aws_security_group" "my_security_group" {  
  name_prefix = "my-security-group"  
  vpc_id      = "vpc-12345678"  
  
  ingress {  
    from_port   = 22  
    to_port     = 22  
    protocol    = "tcp"  
    cidr_blocks = ["0.0.0.0/0"]  
  }  
  
  ingress {  
    from_port   = 80  
    to_port     = 80  
    protocol    = "tcp"  
    cidr_blocks = ["0.0.0.0/0"]  
  }  
  
  egress {  
    from_port   = 0  
    to_port     = 0  
    protocol    = "-1"  
    cidr_blocks = ["0.0.0.0/0"]  
  }  
  
  tags = {  
    Name = "my-security-group"  
  }  
}  



provider "aws" {  
  region = "us-east-1"  
}  
  
resource "aws_api_gateway_rest_api" "my_api" {  
  name        = "my-api"  
  description = "My API Gateway"  
}  
  
resource "aws_api_gateway_resource" "my_resource" {  
  rest_api_id = aws_api_gateway_rest_api.my_api.id  
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id  
  path_part   = "my-resource"  
}  
  
resource "aws_api_gateway_method" "my_method" {  
  rest_api_id   = aws_api_gateway_rest_api.my_api.id  
  resource_id   = aws_api_gateway_resource.my_resource.id  
  http_method   = "GET"  
  authorization = "NONE"  
}  
  
resource "aws_api_gateway_integration" "my_integration" {  
  rest_api_id             = aws_api_gateway_rest_api.my_api.id  
  resource_id             = aws_api_gateway_resource.my_resource.id  
  http_method             = aws_api_gateway_method.my_method.http_method  
  integration_http_method = "GET"  
  type                    = "HTTP"  
  uri                     = "https://www.example.com"  
}  
  
resource "aws_api_gateway_deployment" "my_deployment" {  
  rest_api_id = aws_api_gateway_rest_api.my_api.id  
  stage_name  = "prod"  
}  
  
output "invoke_url" {  
  value = aws_api_gateway_deployment.my_deployment.invoke_url  
}  

