resource "aws_instance" "bastion" {
  ami                         = "ami-0cda11afd45b74b89"
  instance_type               = "t3.small"
  subnet_id                   = aws_subnet.public.id
  key_name                    = "mykey"
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "Bastion-Host"
  }
}
# Private EC2
resource "aws_instance" "private" {
  ami                    = "ami-0cda11afd45b74b89"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private.id
  key_name               = "mykey"
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = {
    Name = "Private-EC2"
  }
}
