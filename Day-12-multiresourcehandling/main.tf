resource "aws_instance" "name" {
    ami = "ami-0bb84b8ffd87024d8"
    instance_type = "t2.micro"
    key_name = "key"

    tags = {
      Name = "newec2"
    }
  
}

resource "aws_s3_bucket" "name" {
    bucket = "hbjgnmk"
  
}
#terraform apply -target=aws_s3_bucket.name #apply or destroy particular resource