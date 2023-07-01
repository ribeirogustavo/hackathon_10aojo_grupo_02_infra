resource "aws_ecs_cluster" "grupotresecs" {
  name = "grupotresecs"
  
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}