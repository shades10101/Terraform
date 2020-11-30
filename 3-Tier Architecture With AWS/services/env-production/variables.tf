variable "vpc_cidr" {
  description = "The cidr range for vpc"
  type        = string
  default     = "10.2.0.0/16"
}

variable "public_subnet_b_cidr" {
  description = "The cidr range for public subnet b"
  type        = string
  default     = "10.2.1.0/24"
}

variable "public_subnet_c_cidr" {
  description = "The cidr range for public subnet c"
  type        = string
  default     = "10.2.2.0/24"
}

variable "private_subnet_b_cidr" {
  description = "The cidr range for private subnet b"
  type        = string
  default     = "10.2.3.0/24"
}

variable "private_subnet_c_cidr" {
  description = "The cidr range for private subnet c"
  type        = string
  default     = "10.2.4.0/24"
}

variable "db_subnet_b_cidr" {
  description = "The cidr range for db subnet b"
  type        = string
  default     = "10.2.5.0/24"
}

variable "db_subnet_c_cidr" {
  description = "The cidr range for db subnet c"
  type        = string
  default     = "10.2.6.0/24"
}

variable "username" {
  description = "RDS username"
}

variable "password" {
  description = "RDS password"
}

variable "instance_class" {
  description = "RDS instance class"
  default     = "db.t2.micro"
}

variable "ami" {
  default = "ami-0fca0f98dc87d39df"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "multi_az" {
  description = "Create a replica in different zone if set to true"
  default     = "true"
}

variable "allocated_storage" {
  description = "The amount of allocated storage"
  default     = "12"
}

variable "skip_final_snapshot" {
  description = "Creates a snapshot when db is deleted if set to true"
  default     = "true"
}