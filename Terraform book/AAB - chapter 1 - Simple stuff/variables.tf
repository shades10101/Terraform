variable list-example {

  type = list(string)
  default = [
    "value1",
    "value2",
  ]
}

variable "ami" {
  type = map(string)
  default = {
    us-east-1 = "ami-0d729a60"
    us-west-1 = "ami-7c4b331c"
  }
  description = "The AMIs to use."
}

variable main_vpc {
  default = "us-east-1-bigdata-farm"
}