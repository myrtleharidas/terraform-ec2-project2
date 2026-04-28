resource "aws_key_pair" "auth_key" {
  key_name   = "${var.project_name}-${var.project_environment}"
  public_key = file("mykey.pub")

  tags = {
    Name        = "${var.project_name}-${var.project_environment}"
    Project     = var.project_name
    Environment = var.project_environment
  }
}

resource "aws_security_group" "webserver" {

  name        = "${var.project_name}-${var.project_environment}-webserver"
  description = "${var.project_name}-${var.project_environment}-webserver"

  tags = {
    Name        = "${var.project_name}-${var.project_environment}-webserver"
    Project     = var.project_name
    Environment = var.project_environment
  }
}

resource "aws_security_group_rule" "webserver_http" {

  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver.id
}

resource "aws_security_group_rule" "webserver_https" {

  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver.id
}

resource "aws_security_group_rule" "webserver_ssh" {

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver.id
}

resource "aws_security_group_rule" "webserver_egress" {

  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webserver.id
}

resource "aws_instance" "webserver" {

  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.auth_key.key_name
  vpc_security_group_ids = [aws_security_group.webserver.id]

  tags = {
    "Name"        = "${var.project_name}-${var.project_environment}-webserver"
    "Project"     = var.project_name
    "Environment" = var.project_environment
  }
}
