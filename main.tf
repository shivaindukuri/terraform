provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "Dev" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.Dev.id
  cidr_block = var.public_subnet[1]
}

resource "aws_subnet" "public2" {
  vpc_id = aws_vpc.Dev.id
  cidr_block = var.public_subnet[2]
}

resource "aws_subnet""private" {
  vpc_id = aws_vpc.Dev.id
  cidr_block =var.private_subnet[1]
}

resource "aws_internet_gateway" "Dev"{
  vpc_id = aws_vpc.Dev.id
}

resource "aws_route_table""Public"{
  vpc_id = aws_vpc.Dev.id 

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Dev.id 
  }
}

resource "aws_route_table_association""Dev"{
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.Public.id
}

resource "aws_network_interface""Dev" {
  subnet_id = aws_subnet.public.id
}

resource"aws_security_group""alb_sg"{
    name = "Apache"
    vpc_id = aws_vpc.Dev.id

    ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.cidr_block]
    }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "web" {
  ami           = var.ami.Prod
  instance_type = var.instance_type.Prod
  subnet_id     = aws_subnet.public.id
  associate_public_ip_address = "true"
  key_name      = var.key_name
  user_data     = file("userdata.sh")
  vpc_security_group_ids = [
    aws_security_group.alb_sg.id
  ] 
}
