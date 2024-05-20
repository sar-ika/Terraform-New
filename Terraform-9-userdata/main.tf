resource "aws_vpc" "dev" {
    cidr_block = "10.0.0.0/16"
 }

 resource "aws_subnet" "name" {
vpc_id = aws_vpc.dev.id
cidr_block = "10.0.0.0/24"
 }


resource "aws_instance" "dev" {
  instance_type = "t2.micro"
  ami = "ami-0bb84b8ffd87024d8"
  subnet_id = aws_subnet.name.id
 associate_public_ip_address = true
 user_data = file ("userdata.sh")

}