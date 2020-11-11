variable key_pair_name {}

resource "random_password" "random_secret" {
  length = 15
  special = false
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

resource "aws_security_group" "mern_security_group" {
  name        = "mern_security_group"
  description = "Allow HTTP, HTTPS, SSH and API inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 223
    to_port     = 223
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "mern_key" {
  key_name   = var.key_pair_name
  public_key = file("secrets/${var.key_pair_name}.pem.pub")
}

data "aws_ami" "amazon_linux_2_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*-x86_64-ebs"]
  }
}

resource "aws_instance" "mern_instance" {
  ami             = data.aws_ami.amazon_linux_2_ami.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.mern_security_group.name]
  key_name        = aws_key_pair.mern_key.key_name

  depends_on = [aws_key_pair.mern_key]

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("secrets/${var.key_pair_name}.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install git gcc-c++ make -y",
      "curl -sL https://rpm.nodesource.com/setup_14.x | sudo -E bash -",
      "sudo amazon-linux-extras install docker",
      "sudo service docker start",
      "sudo usermod -a -G docker ec2-user",
      "sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",
      "git clone https://github.com/allemonta/boilerplates",
      "cd boilerplates/MERN",
      "npm i",
      "cp sample.env .env",
      "npm start"
    ]
  }
}

resource "null_resource" "output" {
  depends_on = [aws_instance.mern_instance ]

  provisioner "local-exec" {
    command = "output.sh ${aws_instance.mern_instance.public_dns} ${aws_key_pair.mern_key.key_name} ${random_password.random_secret.result}"
  }
}

output "SECRETS" {
  value = "Le varie credenziali di accesso sono state salvate nel file secrets/secrets.txt"
}