variable "aws_region" {
    description = "AWS region thats being used"
}
variable "availability_zone_1" {
    description = "AZ"
}
variable "availability_zone_2" {
    description = "AZ"
}
variable "vpc_id" {
    description = "VPC ID"
}
variable "instance_type" {
    description = "The instance type that will be provisioned"
}
variable "db_storage_type" {
    description = "Storage type"
}
variable "ami_details" {
  description = "AMI details so we get new ami"
}
variable "root_vol_type" {
  description = "Root volume type"
}
variable "allocated_storage" {
    description = "how much storage?"
}
variable "ami_owner" {
  description = "Who owns the ami"
}
variable "vir_type" {
  description = "Virtualization type "
}
variable "key_name" {
    description = "Key pair name"
}
variable "user_data_path" {
    description = "User data script path"
}
variable "db_engine" {
    description = "The db engine that we will provision"
}
variable "enable_lc_monitoring" {
    description = "Launch config monitoring"
}
variable "engine_version" {
    description = "Engine version to provision"
}
variable "db_instance_class" {
    description = "Instance class to provision"
}
variable "db_identifier" {
    description = "The db identifier"
}
variable "db_name" {
    description = "DB name"
}
variable "db_username" {
    description = "DB username, set in TF_VARS"
}
variable "db_password" {
    description = "DB password, set in TF_VARS"
}
variable "db_skip_final_snapshot" {
    description = "Would you like to create the snapshot"
}
variable "db_backup_retention_period" {
    description = "backup retention"
}
variable "asg_health_check_gc" {
    description = "Health check"
}
variable "asg_health_check_type" {
    description = "Health check type"
}
variable "asg_min_size" {
    description = "ASG minimum size"
}
variable "asg_max_size" {
    description = "ASG maximum size"
}
variable "asg_desired_size" {
    description = "Desired size of ASG"
}
variable "pub_subnet_1_id" {
    description = "Public subnet"
}
variable "iam_instance_profile_name" {
    description = "iam instance profile"
}
variable "web_server_sg_id" {
    description = "SG ID"
}
variable "rds_subnet_name" {
    description = "RDS subnet name"
}
variable "rds_sg_id" {
    description = "RDS SG ID"
}
variable "lb_sg_id" {
    description = "LoadBalancer Security Group ID"
}
variable "pub_subnet_2_id" {
    description = "Public subnet"
}