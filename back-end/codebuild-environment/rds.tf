resource "random_string" "codebuild-rds-database-password" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# rds
resource "aws_db_instance" "codebuild-rds-database" {
  allocated_storage       = 10
  engine                  = "mysql"
  engine_version          = "5.7.25"
  instance_class          = "db.t2.micro"
  identifier              = "codebuild"
  name                    = "thyart_codebuild"
  username                = "thyartcodebuild"
  password                = "${random_string.codebuild-rds-database-password.result}"
  db_subnet_group_name    = "${aws_db_subnet_group.codebuild-rds-subnet-group.name}"
  parameter_group_name    = "default.mysql5.7"
  multi_az                = "false"
  vpc_security_group_ids  = ["${aws_security_group.codebuild-rds-security-group.id}"]
  storage_type            = "gp2"
  skip_final_snapshot     = true
  backup_retention_period = 30

  tags {
    Name = "rds-codebuild"
  }
}

resource "aws_db_subnet_group" "codebuild-rds-subnet-group" {
  name        = "rds-codebuild"
  description = "RDS subnet group"
  subnet_ids  = ["${aws_subnet.codebuild-subnet-private-1.id}", "${aws_subnet.codebuild-subnet-private-2.id}"]
}
