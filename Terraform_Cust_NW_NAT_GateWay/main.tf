resource "aws_vpc" "cust_VPC" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "cust_SB" {  
vpc_id = aws_vpc.cust_VPC.id
cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "cust_SB_pvt" {  
vpc_id = aws_vpc.cust_VPC.id
cidr_block = "10.0.1.0/24"
}

resource "aws_internet_gateway" "cust_IG" {
  
}

resource "aws_internet_gateway_attachment" "a" {
vpc_id = aws_vpc.cust_VPC.id
internet_gateway_id = aws_internet_gateway.cust_IG.id
}

resource "aws_route_table" "cust_RT" {
vpc_id = aws_vpc.cust_VPC.id
route {
    gateway_id = aws_internet_gateway.cust_IG.id
    cidr_block = "0.0.0.0/0"
}
}

resource "aws_route_table_association" "a" {
subnet_id = aws_subnet.cust_SB.id
route_table_id = aws_route_table.cust_RT.id
}

resource "aws_security_group" "cust_SG" {
    vpc_id = aws_vpc.cust_VPC.id
    name = "allow_TLS"
  
  
  ingress {
    description = "TLS from VPC"
    from_port = "80"
    to_port = "80"
    protocol = "TCP"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
   from_port = "22"
    to_port = "22"
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
 egress {
from_port = 0
to_port= 0
 protocol  = "-1"
cidr_blocks = ["0.0.0.0/0"]

 }

  tags = {
  Name = "cust_sG"
  }
    
 
}



resource "aws_instance" "ec2" {
    instance_type = "t2.micro"
    ami = "ami-07caf09b362be10b8"
    key_name = "Key"
    subnet_id = aws_subnet.cust_SB.id
    vpc_security_group_ids = [aws_security_group.cust_SG.id]
    associate_public_ip_address = true
}

resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.cust_SB.id

  tags = {
    Name = "gw NAT"
  }

 
}

resource "aws_route_table" "pvt_RT" {
vpc_id = aws_vpc.cust_VPC.id
route {
    gateway_id = aws_nat_gateway.nat_gateway.id
    cidr_block = "0.0.0.0/0"
}

}

resource "aws_route_table_association" "c" {
subnet_id = aws_subnet.cust_SB_pvt.id
route_table_id = aws_route_table.pvt_RT.id
}

resource "aws_instance" "pvtec2" {
instance_type = "t2.micro"
key_name = "Key"
ami = "ami-07caf09b362be10b8"
subnet_id = aws_subnet.cust_SB_pvt.id
vpc_security_group_ids = [aws_security_group.cust_SG.id]
}