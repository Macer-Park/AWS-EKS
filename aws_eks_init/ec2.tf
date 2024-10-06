resource "aws_instance" "EKSEC2" {
  instance_type               = var.my_instance_type
  ami                         = var.latest_ami_id
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.PublicSubnet1.id
  security_groups             = [aws_security_group.EKSEC2SG.id]
  associate_public_ip_address = true
  private_ip                  = "192.168.1.100"
  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    delete_on_termination = true
  }
  tags = {
    Name = "${var.cluster_base_name}-host"
  }

  # User Data
  user_data = templatefile("${path.module}/user_data/user_data_eksec2.sh.tpl", {
    ClusterBaseName = var.cluster_base_name
    AWSRegion       = var.target_region
  })
}