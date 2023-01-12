provider "aws" {
  region = "eu-west-1"
  profile = "Biju"
}
resource "aws_instance" "web-1" {
  ami           = "ami-096800910c1b781ba" # eu-west-1
  instance_type = "t2.micro"

  tags = {
    Name = "web-1"
  }
}