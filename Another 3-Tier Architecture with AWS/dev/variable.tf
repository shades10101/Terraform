variable "availability_zone_1" {
    default = "ca-central-1a"
}
variable "availability_zone_2" {
    default = "ca-central-1b"
}
variable "db_storage_type" {
    default = "gp2"
}
variable "allocated_storage" {
    default = "10"
}
variable "ami_details" { # Amazon AMI
  default = "amzn-ami-hvm-*-*-gp2"
}
variable "vir_type" {
  default = "hvm"
}
variable "root_vol_type" {
  default = "ebs"
}
variable "ami_owner" {
  default = "amazon"
}
variable "enable_lc_monitoring" {
    default = "true"
}
variable "ws_irules" {
  type    = list(number) // Tells Terraform this is a list with only number values
  default = [80, 443]
}
variable "ws_erules" {
  type    = list(number)
  default = [0]
}
variable "app_irules" {
  type    = list(number) // Tells Terraform this is a list with only number values
  default = [80, 443, 5432]
}
variable "app_erules" {
  type    = list(number)
  default = [0]
}
variable "rds_irules" {
  type    = list(number)
  default = [3306]
}
variable "rds_erules" {
  type    = list(number)
  default = [0]
}
variable "alb_irules" {
  type    = list(number)
  default = [443, 80]
}
variable "alb_erules" {
  type    = list(number)
  default = [0]
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "pub_cidr_1" {
  default = "10.0.1.0/24"
}
variable "pub_cidr_2" {
  default = "10.0.2.0/24"
}
variable "private_cidr_1" {
  default = "10.0.3.0/24"
}
variable "private_cidr_2" {
  default = "10.0.4.0/24"
}
variable "ssh_ip" {

} #Provide in TF_Vars
variable "aws_region" {
  default = "ca-central-1"
}
variable "instance_type" {
  default = "t2.micro" 
}
variable "db_engine" {
  default = "mysql"
}
variable "engine_version" {
  default = "5.6.37"
}
variable "db_instance_class" {
  default = "db.t2.micro"
}
variable "db_identifier" {
  default = "proddb"
}
variable "db_name" {
  default = "db_prod"
}
variable "db_username" {}
variable "db_password" {}
#
variable "db_skip_final_snapshot" {
  default = "true"
}
variable "db_backup_retention_period" {
  default = "14" 
}
variable "asg_health_check_gc" {
  default = "300"
}
variable "asg_health_check_type" {
  default = "ELB"
}
variable "asg_min_size" {
  default = "1"
}
variable "asg_max_size" {
  default = "3"
}
variable "asg_desired_size" {
  default = "1"
}
variable "key_name" {
  default = "devkey"
}
variable "user_data_path" {
  default = "boot_script.sh"
}