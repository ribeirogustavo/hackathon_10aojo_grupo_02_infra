resource "aws_ecr_repository" "grupotresecr" { 
  name = "grupotresecr"  
  image_tag_mutability = "MUTABLE"  
  image_scanning_configuration {  
    scan_on_push = true  
  }  
}