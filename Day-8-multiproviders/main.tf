resource "aws_s3_bucket" "provider1" {
  bucket = "dfsgh"
}

resource "aws_s3_bucket" "provider2" {
  bucket = "ghnji"
  provider = aws.America
}
resource "aws_s3_bucket" "provider3" {
  bucket = "kmhno"
  provider = aws.Ohlo
}