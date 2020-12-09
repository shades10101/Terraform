output "out_vpc_id" {
  value = aws_vpc.vpc.id
}
output "out_vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}
output "out_pub_subnet_1_id" {
  value = aws_subnet.pub_subnet_1.id
}
output "out_pub_subnet_2_id" {
  value = aws_subnet.pub_subnet_2.id
}
output "out_pvt_subnet_1_id" {
  value = aws_subnet.pvt_subnet_1.id
}
output "out_pvt_subnet_2_id" {
  value = aws_subnet.pvt_subnet_2.id
}
output "out_rds_subnet_name" {
  value = aws_db_subnet_group.rds_subnet.name
}