provider "aws" {
  region = "ca-central-1"
}
module "instance" {
  source = "./modules/"
  sg_name = "SecurityG"
  in_port = "80"
  out_port = "80"
  proto = "TCP"

  ec2name = "db_az01"
}
