data "aws_vpc" "existing" {
  id = var.vpc_id
}

# EKS Public Subnet - AZ 1
resource "aws_subnet" "eks_public_az1" {
  vpc_id                  = data.aws_vpc.existing.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true

  tags = {
    Name                     = "task20-eks-public-az1"
    "kubernetes.io/role/elb" = "1"
  }
}

# EKS Private Subnet - AZ 1
resource "aws_subnet" "eks_private_az1" {
  vpc_id            = data.aws_vpc.existing.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-north-1a"

  tags = {
    Name                              = "task20-eks-private-az1"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

# EKS Public Subnet - AZ 2
resource "aws_subnet" "eks_public_az2" {
  vpc_id                  = data.aws_vpc.existing.id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "eu-north-1b"
  map_public_ip_on_launch = true

  tags = {
    Name                     = "task20-eks-public-az2"
    "kubernetes.io/role/elb" = "1"
  }
}

# EKS Private Subnet - AZ 2
resource "aws_subnet" "eks_private_az2" {
  vpc_id            = data.aws_vpc.existing.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "eu-north-1b"

  tags = {
    Name                              = "task20-eks-private-az2"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

# Public Route Table - AZ 1
resource "aws_route_table" "eks_public_az1" {
  vpc_id = data.aws_vpc.existing.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name = "task20-eks-public-az1-rt"
  }
}

resource "aws_route_table_association" "eks_public_az1" {
  subnet_id      = aws_subnet.eks_public_az1.id
  route_table_id = aws_route_table.eks_public_az1.id
}

# Private Route Table - AZ 1
resource "aws_route_table" "eks_private_az1" {
  vpc_id = data.aws_vpc.existing.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = "task20-eks-private-az1-rt"
  }
}

resource "aws_route_table_association" "eks_private_az1" {
  subnet_id      = aws_subnet.eks_private_az1.id
  route_table_id = aws_route_table.eks_private_az1.id
}

# Public Route Table - AZ 2
resource "aws_route_table" "eks_public_az2" {
  vpc_id = data.aws_vpc.existing.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name = "task20-eks-public-az2-rt"
  }
}

resource "aws_route_table_association" "eks_public_az2" {
  subnet_id      = aws_subnet.eks_public_az2.id
  route_table_id = aws_route_table.eks_public_az2.id
}

# Private Route Table - AZ 2
resource "aws_route_table" "eks_private_az2" {
  vpc_id = data.aws_vpc.existing.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = "task20-eks-private-az2-rt"
  }
}

resource "aws_route_table_association" "eks_private_az2" {
  subnet_id      = aws_subnet.eks_private_az2.id
  route_table_id = aws_route_table.eks_private_az2.id
}
