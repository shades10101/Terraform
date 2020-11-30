variable "ingress" {
  type = list(number)
  default = [80,443,25,3306,3389,8080]
}

variable "egress" {
  type = list(number)
  default = [80,443]
}

variable "ami" {
    default = "ami-054362537f5132ce2"
}