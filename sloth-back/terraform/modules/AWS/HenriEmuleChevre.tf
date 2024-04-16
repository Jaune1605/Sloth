# Paramètres de la configuration
resource "aws_instance" "HenriEmuleChevre" {
  ami = "ami-00c71bd4d220aa22a"
  instance_type = "t2.micro"
  tags = {
    Name = "HenriEmuleChevre"
  }
}