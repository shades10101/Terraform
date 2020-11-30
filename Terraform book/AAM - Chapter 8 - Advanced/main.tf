provider "aws" {
  region = "ca-central-1"
}

// Calls module to create 3 Servers
module "instances" {
  source = "./modules/"
  servers = ["ws1","ws2","ws3"]
}

// This will output the IP addresses from a child module
// But the Output needs to be decalred in the child module or else Terraform would never
// be able to find the values
output "public-ips" {
  value = module.instances.public_ip
}
