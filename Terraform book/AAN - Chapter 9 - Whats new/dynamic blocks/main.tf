/*
This is used to add multiple values for a resource block but only having to add the default vales in the variable
*/
variable "irules" {
  type = list(number) // Tells Terraform this is a list with only number values
  default = [80,443]
}
variable "erules" {
  type = list(number)
  default = [80,443]
}

resource "aws_security_group" "allow" {
  name = "allow HTTP/HTTPS"
  description = "allow HTTP/HTTPS"

  dynamic "irules" {
    iterator = port // can be named anything, just a place holder for the value of the list
    for_each = var.irules // Goes through the list as a for loop looking at each value of irules (80 and 443)
    content {
    from_port = port.value //looks at the value of the iterator and assigns it that value
    to_port = port.value
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    }
  }

  // Now it does the same thing for egress rules.
  dynamic "erules" {
    iterator = port
    for_each = var.erules
    content {
    from_port = port.value
    to_port = port.value
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    }
}