provider "aws" {
  profile = "default"
  # apply the region from the variables.tf file
  region = var.region
  #region = "us-east-1"
}

#resource "aws_s3_bucket" "example" {
#  # NOTE: S3 bucket names must be unique across _all_ AWS accounts, so
#  # this name must be changed before applying this example to avoid naming
#  # conflicts.
#  bucket = "baileyheath-terraform-started-guide"
#  acl    = "private"
#}

#resource "aws_instance" "example" {
#  ami = var.amis[var.os]
#  instance_type = "t2.micro"
#
#  provisioner "local-exec" {
#      command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
#  }
#
#  # Tells Terraform the aws_instance depends on the s3 bucket"
#  depends_on = [aws_s3_bucket.example]
#}

resource "aws_instance" "bailey-test" {
  ami = var.amis[var.os]
  instance_type = var.instance_type
  key_name = var.key_name

  provisioner "remote-exec" {
    inline = ["sudo dnf -y install python"]

    connection {
      type = "ssh"
      user = "ubuntu"
      host = "${self.public_ip}"
      private_key = "${var.ssh_private_key}"
    }
  }
  
  provisioner "local-exec" {
    command = "ansible-playbook -i '${self.public_ip},' --private-key ${var.ssh_private_key} hello.yml"
  }
  tags = {
      Name = "bailey-test"
      Description = "terraform is cool"
  }
}

#resource "aws_eip" "ip" {
#  vpc = true
#  instance = aws_instance.example.id
#}

output "ami" {
  value = aws_instance.bailey-test.ami
}