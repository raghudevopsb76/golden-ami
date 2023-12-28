resource "aws_instance" "ami" {
  ami           = data.aws_ami.ami.id
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-033d8567b50d2e180"]
  tags = {
    Name = "golden-ami"
  }
}

resource "null_resource" "install" {
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "root"
      password = var.root_password
      host     = aws_instance.ami.private_ip
    }
    inline = [
      "labauto ansible"
    ]
  }
}
