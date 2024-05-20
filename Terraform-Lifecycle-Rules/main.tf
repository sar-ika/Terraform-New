resource "aws_s3_bucket" "remote" {
  bucket = "abcghj"

  tags = {
Name = "s3"
  }
    

lifecycle {
    create_before_destroy = true
  }

}