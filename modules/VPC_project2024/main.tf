resource "aws_vpc" "project2024" {
     cidr_block = var.project2024_vpc
     enable_dns_hostnames = true
     enable_dns_support = true
     tags = {
        name = "project-2024-vpc"
     }
}

resource "aws_subnet" "project2024_pubsub" {

    cidr_block = var.project2024_pubsub
    vpc_id = aws_vpc.project2024.id
    map_public_ip_on_launch = true
    tags = {
        Name = "mypub-subnet"
    }
}

resource "aws_subnet" "project2024_privsub" {

    cidr_block = var.project2024_privsub
    vpc_id = aws_vpc.project2024.id
    tags = {
        Name = "mypri-subnet"
    }
}

resource "aws_internet_gateway" "project2024_IGW" {

       vpc_id = aws_vpc.project2024.id
       tags = {
         Name = "Project2024-IGW"
       } 
}

resource "aws_route_table" "project2024_rt" {
       vpc_id = aws_vpc.project2024.id
       route {
          cidr_block = "0.0.0.0/0"
          gateway_id = aws_internet_gateway.project2024_IGW.id
       }
}

resource "aws_route_table_association" "tr_associate" {
          subnet_id = aws_subnet.project2024_pubsub.id
          route_table_id = aws_route_table.project2024_rt.id
}

resource "aws_security_group" "mysg" {
     vpc_id = aws_vpc.project2024.id       
     name = "my-sg"
     dynamic ingress {
            iterator = port
            for_each = var.port
            content {
            description      = "TLS from VPC"
            from_port        =  port.value
            to_port          =  port.value
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
            }
        }
        egress {
            from_port        = 0
            to_port          = 0
            protocol         = "-1"
            cidr_blocks      = ["0.0.0.0/0"]
        }
        tags = {
            Name = "allow_tls"
        }
}