resource "aws_vpc" "EksVPC" {
  cidr_block           = var.vpc_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.cluster_base_name}-VPC"
  }
}

resource "aws_subnet" "PublicSubnet1" {
  availability_zone       = var.availability_zone1
  cidr_block              = var.public_subnet1_block
  vpc_id                  = aws_vpc.EksVPC.id
  map_public_ip_on_launch = true
  tags = {
    Name                     = "${var.cluster_base_name}-PublicSubnet1"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "PublicSubnet2" {
  availability_zone       = var.availability_zone2
  cidr_block              = var.public_subnet2_block
  vpc_id                  = aws_vpc.EksVPC.id
  map_public_ip_on_launch = true
  tags = {
    Name                     = "${var.cluster_base_name}-PublicSubnet2"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_internet_gateway" "InternetGateway" {
  tags = {
    Name = "${var.cluster_base_name}-InternetGateway"
  }
}

resource "aws_internet_gateway_attachment" "VPCGatewayAttachment" {
  internet_gateway_id = aws_internet_gateway.InternetGateway.id
  vpc_id              = aws_vpc.EksVPC.id
}

resource "aws_route_table" "PublicSubnetRouteTable" {
  vpc_id = aws_vpc.EksVPC.id
  tags = {
    Name = "${var.cluster_base_name}-PublicSubnetRouteTable"
  }
}

resource "aws_route" "PublicSubnetRoute" {
  route_table_id         = aws_route_table.PublicSubnetRouteTable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.InternetGateway.id
}

resource "aws_route_table_association" "PublicSubnet1RouteTableAssociation" {
  subnet_id      = aws_subnet.PublicSubnet1.id
  route_table_id = aws_route_table.PublicSubnetRouteTable.id
}

resource "aws_route_table_association" "PublicSubnet2RouteTableAssociation" {
  subnet_id      = aws_subnet.PublicSubnet2.id
  route_table_id = aws_route_table.PublicSubnetRouteTable.id
}

resource "aws_subnet" "PrivateSubnet1" {
  availability_zone = var.availability_zone1
  cidr_block        = var.private_subnet1_block
  vpc_id            = aws_vpc.EksVPC.id
  tags = {
    Name                              = "${var.cluster_base_name}-PrivateSubnet1"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "PrivateSubnet2" {
  availability_zone = var.availability_zone2
  cidr_block        = var.private_subnet2_block
  vpc_id            = aws_vpc.EksVPC.id
  tags = {
    Name                              = "${var.cluster_base_name}-PrivateSubnet2"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_route_table" "PrivateSubnetRouteTable" {
  vpc_id = aws_vpc.EksVPC.id
  tags = {
    Name = "${var.cluster_base_name}-PrivateSubnetRouteTable"
  }
}

resource "aws_route_table_association" "PrivateSubnet1RouteTableAssociation" {
  subnet_id      = aws_subnet.PrivateSubnet1.id
  route_table_id = aws_route_table.PrivateSubnetRouteTable.id
}

resource "aws_route_table_association" "PrivateSubnet2RouteTableAssociation" {
  subnet_id      = aws_subnet.PrivateSubnet2.id
  route_table_id = aws_route_table.PrivateSubnetRouteTable.id
}

