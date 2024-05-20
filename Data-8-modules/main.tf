resource "aws_instance" "ec2" {
  instance_type = var.instance_type
  ami =var.ami
}

resource "aws_s3_bucket" "name" {
  bucket = "ghnfj"
}