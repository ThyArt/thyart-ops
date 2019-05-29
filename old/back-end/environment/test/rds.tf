resource "random_string" "test-rds-database-password" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# rds
resource "aws_db_instance" "test-rds-database" {
  allocated_storage       = 10
  engine                  = "mysql"
  engine_version          = "5.7.25"
  instance_class          = "db.t2.micro"
  identifier              = "${var.application_name}-test"
  name                    = "thyart"
  username                = "thyartapi"
  password                = "${random_string.test-rds-database-password.result}"
  db_subnet_group_name    = "${aws_db_subnet_group.test-rds-subnet-group.name}"
  parameter_group_name    = "default.mysql5.7"
  multi_az                = "false"
  vpc_security_group_ids  = ["${aws_security_group.test-rds-security-group.id}"]
  storage_type            = "gp2"
  skip_final_snapshot     = true
  backup_retention_period = 30

  tags = {
    Name = "rds-${var.application_name}-test"
  }
}

resource "aws_db_subnet_group" "test-rds-subnet-group" {
  name        = "rds-${var.application_name}-test"
  description = "RDS subnet group"

  subnet_ids = [
    "${data.aws_subnet.backend-subnet-private-1.id}",
    "${data.aws_subnet.backend-subnet-private-2.id}",
    "${data.aws_subnet.backend-subnet-private-3.id}",
  ]
}
