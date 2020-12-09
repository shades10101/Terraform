resource "aws_security_group" "web_server_sg" {
  name        = "web_server_sg"
  description = "allow HTTP/HTTPS"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    iterator = port              // can be named anything, just a place holder for the value of the list
    for_each = var.ws_irules // Goes through the list as a for loop looking at each value of irules
    content {
      from_port   = port.value //looks at the value of the iterator and assigns it that value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  // Now it does the same thing for egress rules.
  dynamic "egress" {
    iterator = port
    for_each = var.ws_erules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
resource "aws_security_group" "app_server_sg" {
  name        = "app_server_sg"
  description = "allow certain ports"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    iterator = port               // can be named anything, just a place holder for the value of the list
    for_each = var.app_irules // Goes through the list as a for loop looking at each value of irules
    content {
      from_port   = port.value //looks at the value of the iterator and assigns it that value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  // Now it does the same thing for egress rules.
  dynamic "egress" {
    iterator = port
    for_each = var.app_erules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "allow certain ports"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    iterator = port               // can be named anything, just a place holder for the value of the list
    for_each = var.rds_irules // Goes through the list as a for loop looking at each value of irules
    content {
      from_port   = port.value //looks at the value of the iterator and assigns it that value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  // Now it does the same thing for egress rules.
  dynamic "egress" {
    iterator = port
    for_each = var.rds_erules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "allow certain ports"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    iterator = port               // can be named anything, just a place holder for the value of the list
    for_each = var.alb_irules // Goes through the list as a for loop looking at each value of irules
    content {
      from_port   = port.value //looks at the value of the iterator and assigns it that value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  // Now it does the same thing for egress rules.
  dynamic "egress" {
    iterator = port
    for_each = var.alb_erules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}