output "dbip" {
  value = aws_instance.db.associate_public_ip_address
}