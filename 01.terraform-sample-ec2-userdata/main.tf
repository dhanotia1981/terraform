provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = "ami-0756a1c858554433e"
  instance_type          = "t2.micro"
  key_name               = "Dhanotia"
  monitoring             = true
  vpc_security_group_ids = ["sg-01fbc1668c1fbecba"]
  subnet_id              = "subnet-0f96b6977ad071f5b"
    user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Name = "terraform-instance"
    Terraform   = "true"
    Environment = "dev"
  }
}
