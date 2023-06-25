resource "aws_vpc" "vpc-criminix-prod" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true

    tags = {
        Name = "vpc-criminix-prod"
        Terraform   = "true"
        Environment = "prod"
    }
}

# resource "aws_subnet" "subnet-criminix-private-us-east-1" {
#     vpc_id     = "${aws_vpc.vpc-criminix-prod.id}"
#     cidr_block = "10.0.0.0/24"
#     availability_zone = "us-east-1a"
#     tags = {
#         Name = "subnet-criminix-private-us-east-1"
#         Terraform   = "true"
#         Environment = "prod"
#     }
#     depends_on = [aws_vpc.vpc-criminix-prod]
# }

resource "aws_subnet" "subnet-criminix-public-us-east-1" {
    vpc_id                  = "${aws_vpc.vpc-criminix-prod.id}"
    cidr_block              = "10.0.1.0/24"
    map_public_ip_on_launch = true
    # availability_zone = "us-east-1a"

    tags = {
        Name = "subnet-criminix-public-us-east-1"
        Terraform   = "true"
        Environment = "prod"
    }

    depends_on = [aws_vpc.vpc-criminix-prod]
}

resource "aws_internet_gateway" "igw-criminix-public-prod" {
    vpc_id = "${aws_vpc.vpc-criminix-prod.id}"

    tags = {
        Name = "igw-criminix-public-prod"
        Terraform   = "true"
        Environment = "prod"
    }

    depends_on = [aws_vpc.vpc-criminix-prod]
}

resource "aws_route_table" "rtb-criminix-public-prod" {
    vpc_id = "${aws_vpc.vpc-criminix-prod.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw-criminix-public-prod.id}"
    }

    tags = {
        Name = "rtb-criminix-public-prod"
        Terraform   = "true"
        Environment = "prod"
    }

    depends_on = [aws_internet_gateway.igw-criminix-public-prod]
}

resource "aws_route_table_association" "rtb-criminix-public-prod" {
    subnet_id = "${aws_subnet.subnet-criminix-public-us-east-1.id}"
    route_table_id = "${aws_route_table.rtb-criminix-public-prod.id}"
    
    depends_on = [aws_route_table.rtb-criminix-public-prod]
}

# Security group default

resource "aws_default_security_group" "default" {
    vpc_id = "${aws_vpc.vpc-criminix-prod.id}"

    ingress {
        protocol  = -1
        self      = true
        from_port = 0
        to_port   = 0
    }

    tags = {
        Name = "restrict_default_sg"
        Terraform   = "true"
        Environment = "prod"
    }
}


# Security group para web
resource "aws_security_group" "allow-sg-web" {
    name        = "allow-access-web"
    description = "allow traffic web"
    vpc_id = "${aws_vpc.vpc-criminix-prod.id}"

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "allow_web"
        Terraform   = "true"
        Environment = "prod"
    }

}

# Liberando portas http
resource "aws_security_group_rule" "http-port-allow" {
    description       = "http-port"
    type              = "ingress"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.allow-sg-web.id}"
}

# Liberando porta https
resource "aws_security_group_rule" "https-port-allow" {
    description       = "https-port"
    type              = "ingress"
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.allow-sg-web.id}"
}


resource "aws_security_group_rule" "airflow-port-allow" {
    description       = "airflow-port"
    type              = "ingress"
    from_port         = 8080
    to_port           = 8080
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.allow-sg-web.id}"
}

resource "aws_security_group_rule" "jupyter-port-allow" {
    description       = "jupyter-port"
    type              = "ingress"
    from_port         = 8888
    to_port           = 8888
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.allow-sg-web.id}"
}

# Security group para web
resource "aws_security_group" "allow-sg-ssh" {
    name        = "allow-ssh-web"
    description = "allow access ssh"
    vpc_id = "${aws_vpc.vpc-criminix-prod.id}"

    ingress {
        description = "allow ssh to ec2"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "allow-ssh"
        Terraform   = "true"
        Environment = "prod"
    }
}

resource "aws_security_group" "allow-sg-db" {
    name        = "allow-database-access"
    description = "allow database mysql port"
    vpc_id = "${aws_vpc.vpc-criminix-prod.id}"

    ingress {
        description = "allow database mysql port"
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "allow-database-access"
        Terraform   = "true"
        Environment = "prod"
    }
}


resource "aws_eip" "eip-public-application" {
    instance                  = aws_instance.application-prod.id
    depends_on                = [aws_internet_gateway.igw-criminix-public-prod]
    tags = {
        Name = "eip-public-application"
        Terraform   = "true"
        Environment = "prod"
    }
}