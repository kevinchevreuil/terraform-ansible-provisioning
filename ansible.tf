resource "local_file" "ansible-inventory" {
  content = templatefile(
    "${path.module}/ansible/ansible-inventory.tftpl",
    {
      ec2-public-ip = aws_instance.kaisen[0].public_ip,
    }
  )
  filename = "${path.module}/ansible/hosts"
  file_permission = "0644"

  connection {
    host        = aws_instance.kaisen[0].public_ip
    type        = "ssh"
    user        = "admin"
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt install python3 -y",
    ]
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --become --become-user root --become-method sudo --private-key ${var.private_key_path} -u admin -i ansible/hosts ansible/apache.yml"
  }
}
