provider "aws" {
  region = var.aws_region
}

module "aws-vpc" {
  source = "../modules/aws-vpc"

    aws_region = var.aws_region
    vpc_cidr =  var.vpc_cidr
    pub_cidr_1 = var.pub_cidr_1
    pub_cidr_2 = var.pub_cidr_2
    availability_zone_1 = var.availability_zone_1
    availability_zone_2 = var.availability_zone_2
    private_cidr_1 = var.private_cidr_1
    private_cidr_2 = var.private_cidr_2
    ssh_ip = var.ssh_ip
}

module "aws-iam" {
  source = "../modules/aws-iam"
}

module "aws-sg" {
  source = "../modules/aws-sg"

    ws_irules = var.ws_irules
    ws_erules = var.ws_erules
    app_irules = var.ws_irules
    app_erules = var.ws_erules
    rds_irules = var.rds_irules
    rds_erules = var.rds_erules
    alb_irules = var.alb_irules
    alb_erules = var.alb_erules
    vpc_id = module.aws-vpc.out_vpc_id
}

module "aws-instance" {
  source = "../modules/aws-instance"

  vpc_id = module.aws-vpc.out_vpc_id
  aws_region = var.aws_region
  key_name = var.key_name
  instance_type = var.instance_type
  pub_subnet_1_id = module.aws-vpc.out_pub_subnet_1_id
  iam_instance_profile_name = module.aws-iam.out_iam_instance_profile_name
  user_data_path = var.user_data_path
  web_server_sg_id = module.aws-sg.out_web_server_sg_id
  db_engine = var.db_engine
  engine_version = var.engine_version
  db_instance_class = var.db_instance_class
  db_identifier = var.db_identifier
  db_name = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  db_skip_final_snapshot = var.db_skip_final_snapshot
  db_backup_retention_period = var.db_backup_retention_period
  rds_subnet_name = module.aws-vpc.out_rds_subnet_name
  rds_sg_id = module.aws-sg.out_rds_sg_id
  lb_sg_id = module.aws-sg.out_lb_sg_id
  pub_subnet_2_id = module.aws-vpc.out_pub_subnet_2_id
  asg_max_size = var.asg_max_size
  asg_min_size = var.asg_min_size
  asg_health_check_gc = var.asg_health_check_gc
  asg_health_check_type = var.asg_health_check_type
  asg_desired_size = var.asg_desired_size
  db_storage_type = var.db_storage_type
  allocated_storage = var.allocated_storage
  ami_details = var.ami_details
  vir_type = var.vir_type
  root_vol_type = var.root_vol_type
  ami_owner = var.ami_owner
  enable_lc_monitoring = var.enable_lc_monitoring
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
}