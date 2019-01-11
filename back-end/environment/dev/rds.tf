resource "random_string" "dev-rds-database-password" {
  length  = 32
  special = true
}

# rds
resource "aws_db_instance" "dev-rds-database" {
  allocated_storage       = 10
  engine                  = "mysql"
  engine_version          = "5.6.41"
  instance_class          = "db.t2.micro"
  identifier              = "${var.application_name}-dev"
  name                    = "thyartdev"
  username                = "thyartapidev"
  password                = "${random_string.dev-rds-database-password.result}"
  db_subnet_group_name    = "${aws_db_subnet_group.dev-rds-subnet-group.name}"
  parameter_group_name    = "default.mysql5.6"
  multi_az                = "false"
  vpc_security_group_ids  = ["${aws_security_group.dev-rds-security-group.id}"]
  storage_type            = "gp2"
  skip_final_snapshot     = true
  backup_retention_period = 30

  tags {
    Name = "rds-${var.application_name}-dev"
  }
}

resource "aws_db_subnet_group" "dev-rds-subnet-group" {
  name        = "rds-${var.application_name}-dev"
  description = "RDS subnet group"
  subnet_ids  = ["${aws_subnet.dev-subnet-private-1.id}", "${aws_subnet.dev-subnet-private-2.id}"]
}
