resource "aws_instance" "kaisen" {
  count                       = "1"
  ami                         = "ami-0c7803c5cf98ab4cd"
  instance_type               = "t2.micro"
  key_name                    = "linux-key-pair"
  vpc_security_group_ids      = [aws_security_group.kaisen.id]
  subnet_id                   = aws_subnet.kaisen.id
  associate_public_ip_address = "true"
  tags = {
    Name = "kaisen"
  }
}
