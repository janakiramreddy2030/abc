resource "aws_instance" "demo" {
    instance_type = "t2.micro"
    ami = "ami-08e0ca9924195beba"
    subnet_id = aws_subnet.Mysubnet.id
    key_name = "jani_demo"
    security_groups = [aws_security_group.div-SG.id]
    provisioner "file" {
        source      = "apache.sh"
        destination = "~/apache.sh"
      connection {
        type     = "ssh"
        user     = "ec2-user"
        private_key = file("C:/Users/Dell/Desktop/key_pairs/jani_demo.pem")
        host     = self.public_ip
    }
  }  
}
# create security group
resource "aws_security_group" "div-SG" {
  name        = "Security-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.demo.id
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "div-name"
  }
}