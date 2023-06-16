resource "tls_private_key" "kaisen_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "kaisen_key_pair" {
  key_name   = "linux-key-pair"
  public_key = tls_private_key.kaisen_key_pair.public_key_openssh
}
resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.kaisen_key_pair.key_name}.pem"
  content  = tls_private_key.kaisen_key_pair.private_key_pem
  file_permission = "0600"
}
