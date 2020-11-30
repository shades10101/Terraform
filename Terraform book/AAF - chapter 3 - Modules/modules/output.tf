variable "subnet_details" {
  type = list(object({
    cidr             = string
    subnet_name      = string
    route_table_name = string
    aznum            = number
  }))
}
 
locals { 
  route_tables_all = distinct([for s in var.subnet_details : s.route_table_name ]) 
}