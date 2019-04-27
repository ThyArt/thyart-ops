resource "aws_instance" "agent-instance" {
  ami                         = "${data.aws_ami.ec2-ami.id}"
  instance_type               = "t2.nano"
  key_name                    = "${var.monitoring_agent_key_pair_name}"
  vpc_security_group_ids      = ["${aws_security_group.monitoring-agent-environment-security-group.id}"]
  subnet_id                   = "${aws_subnet.monitoring-agent-subnet-public-1.id}"
  associate_public_ip_address = true

  tags {
    Name = "datadog agent"
  }

  provisioner "remote-exec" {
    inline = [
      "DD_API_KEY=${var.datadog_api_key} bash -c \"$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)\"",
    ]

    connection {
      host        = "${aws_instance.agent-instance.public_dns}"
      user        = "ec2-user"
      private_key = "${file(var.monitoring_agent_ssh_key)}"
    }
  }
}
