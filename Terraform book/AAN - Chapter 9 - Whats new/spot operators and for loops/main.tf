provider "aws" {
  region = "ca-central-1"
}

variable "ingress" {
  type = list(number)
  default = [80,443]
}
variable "egress" {
  type = list(number)
  default = [80,443]
}

resource "aws_security_group" "allow" {
  name = "allow HTTPS"

  dynamic "ingress" {
    iterator = port // can be named anything, just a place holder for the value of the list
    for_each = var.ingress // Goes through the list as a for loop
    content {
    from_port = port.value //looks at the value of the iterator and assigns it that value
    to_port = port.value
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress" {
    iterator = port
    for_each = var.egress
    content {
    from_port = port.value
    to_port = port.value
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
// For loop example - For loops give more options
output "checklist" {
  // With for loops there is two different values you can have:
  // 1) [] List/Array: Returns elements inside of a list
  // 2) {} Object: Returns an object
  value = [ for i in var.ingress : "Port ${i} expected to be open"]
  // For is a loop
  // i is a placeholder for the value of the variable
  // in means in 
  // Collan means what do you want to do with that value
}
// Spot operator example - displays everything, not as granular. 
output "expected" {
  value = aws_security_group.allow[*].ingress
}