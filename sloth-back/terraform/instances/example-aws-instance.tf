# Paramètres de la configuration
resource "aws_instance" "example-aws-instance" {
  ami = "ami-00c71bd4d220aa22a"
  instance_type = "t2.micro"
  tags = {
    Name = "example-aws-instance"
  }
}