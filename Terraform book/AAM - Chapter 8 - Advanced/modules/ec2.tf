variable "servers" {
  type = list
}


resource "aws_instance" "db" {
  ami = "ami-054362537f5132ce2"
  instance_type = "t2.micro"
  count = length(var.servers) // looks at the list variable and finds a length of 3 (the 3 servers we decalres WS1, WS2, WS3)
  associate_public_ip_address = true
  tags = {
    Name = var.servers[count.index] //starts from 0, will reference the server names
  }
}

// This output will not be displayed on the CLI when running a Terrform apply.
output "public_ip" {
  value = [aws_instance.db.*.public_ip] // the star references each count server created
}
