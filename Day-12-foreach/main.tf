variable "ami" {
  type    = string
  default = "ami-0bb84b8ffd87024d8"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "sandboxes" {
  type    = list(string)
  default = ["dev","test"]
}


resource "aws_instance" "sandbox" {
  ami           = var.ami
  instance_type = var.instance_type
  for_each      = toset(var.sandboxes)
#   count = length(var.sandboxes)
  tags = {
    Name = each.value # for a set, each.value and each.key is the same
  }


#   tags = {
#     Name = var.sandboxes[count.index] # example for count
#   }
}