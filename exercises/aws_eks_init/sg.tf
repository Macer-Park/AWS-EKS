resource "aws_security_group" "EKSEC2SG" {
  description = "eksctl-host Security Group"
  vpc_id      = aws_vpc.EksVPC.id
  tags = {
    Name = "${var.cluster_base_name}-HOST-SG"
  }

  ingress {
    protocol    = "all"
    cidr_blocks = [var.sg_ingress_ssh_cidr]
    from_port   = 0
    to_port     = 0
  }

  egress {
    protocol    = "all"
    from_port   = 0
    to_port     = 0
    cidr_blocks = [var.sg_ingress_ssh_cidr]
  }
}