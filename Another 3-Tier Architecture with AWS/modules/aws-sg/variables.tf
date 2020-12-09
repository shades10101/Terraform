variable "ws_irules" {
  type    = list(number) // Tells Terraform this is a list with only number values
}
variable "ws_erules" {
  type    = list(number)
}
variable "app_irules" {
  type    = list(number) // Tells Terraform this is a list with only number values
}
variable "app_erules" {
  type    = list(number)
}
variable "rds_irules" {
  type    = list(number)
}
variable "rds_erules" {
  type    = list(number)
}
variable "alb_irules" {
  type    = list(number)
}
variable "alb_erules" {
  type    = list(number)
}
variable "vpc_id" {}