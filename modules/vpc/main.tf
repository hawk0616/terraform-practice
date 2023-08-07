resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
}

resource "aws_subnet" "private_subnet_1b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
}

resource "aws_subnet" "private_subnet_2a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.5.0/24"
}

resource "aws_subnet" "private_subnet_2b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.6.0/24"
}

resource "aws_nat_gateway" "nat_gw_1" {
  allocation_id = aws_eip.nat_eip_1.id
  subnet_id     = aws_subnet.public_subnet_1.id
}

resource "aws_nat_gateway" "nat_gw_2" {
  allocation_id = aws_eip.nat_eip_2.id
  subnet_id     = aws_subnet.public_subnet_2.id
}

resource "aws_eip" "nat_eip_1" {}

resource "aws_eip" "nat_eip_2" {}

resource "aws_route_table" "private_rt_1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_1.id
  }
}

resource "aws_route_table" "private_rt_2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_2.id
  }
}

resource "aws_route_table_association" "private_rta_1a" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.private_rt_1.id
}

resource "aws_route_table_association" "private_rta_1b" {
  subnet_id      = aws_subnet.private_subnet_1b.id
  route_table_id = aws_route_table.private_rt_1.id
}

resource "aws_route_table_association" "private_rta_2a" {
  subnet_id      = aws_subnet.private_subnet_2a.id
  route_table_id = aws_route_table.private_rt_2.id
}

resource "aws_route_table_association" "private_rta_2b" {
  subnet_id      = aws_subnet.private_subnet_2b.id
  route_table_id = aws_route_table.private_rt_2.id
}