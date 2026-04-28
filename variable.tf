variable "aws_region" {
  description = "my aws region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "my project name"
  type        = string
  default     = "zomato"
}

variable "project_environment" {
  description = "my project environment"
  type        = string
  default     = "production"
}

variable "instance_type" {
  description = "instance type"
  type        = string
  default     = "t3.micro"
}

variable "instance_ami" {
  description = "my instance ami id"
  type        = string
  default     = "ami-0317b0f0a0144b137"
}
