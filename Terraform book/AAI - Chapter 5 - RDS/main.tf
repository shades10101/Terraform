provider "aws" {
  region = "ca-central-1"
}

resource "aws_db_instance" "myRds" {
  name = "mydb" //name of the database, lowercase & alphanumeric only, no dahes.
  identifier = "my-first-rds" //name of the RDS instance, lowercase, dashes are allowed
  instance_class = "db.t2.micro"
  engine = "mariadb"
  engine_version = "10.2.21"
  username = "bob"
  password = "password123"
  port = 3306
  allocated_storage = 20
  skip_final_snapshot = true //set false if prod
}
