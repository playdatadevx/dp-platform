resource "aws_subnet" "public_1" {
  vpc_id = aws_vpc.main.id

  cidr_block = "192.168.0.0/18"

  availability_zone = "${local.region}a"

  map_public_ip_on_launch = true

  tags = {
    Name = "public-sn-1a"
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}

resource "aws_subnet" "public_2" {
  vpc_id = aws_vpc.main.id

  cidr_block = "192.168.64.0/18"

  availability_zone = "${local.region}c"

  map_public_ip_on_launch = true

  tags = {
    Name = "public-sn-2c"
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = 1
  }
}


resource "aws_subnet" "private_1" {
  vpc_id = aws_vpc.main.id

  cidr_block = "192.168.128.0/18"

  availability_zone = "${local.region}a"

  tags = {
    Name = "private-sn-1a"
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "private_2" {
  vpc_id = aws_vpc.main.id

  cidr_block = "192.168.192.0/18"

  availability_zone = "${local.region}c"

  tags = {
    Name = "private-sn-2c"
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}
