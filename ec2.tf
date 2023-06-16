resource "aws_instance" "kaisen" {
  count                       = "1"
  instance_type               = "t2.micro"
  ami                         = "ami-0a9d5908c7201e91d"
  key_name                    = "linux-key-pair"
  vpc_security_group_ids      = [aws_security_group.kaisen_sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "kaisen"
  }
}
