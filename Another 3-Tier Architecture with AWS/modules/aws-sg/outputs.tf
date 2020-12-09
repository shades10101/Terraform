output "out_web_server_sg_id" {
  value = aws_security_group.web_server_sg.id
}
output "out_app_server_sg_id" {
  value = aws_security_group.app_server_sg.id
}
output "out_rds_sg_id" {
  value = aws_security_group.rds_sg.id
}
output "out_lb_sg_id" {
  value = aws_security_group.lb_sg.id
}