# Instancia para o Airflow + Spark
resource "aws_instance" "data-engineering-prod" {
    ami                  = var.amis["us-east-1"]
    instance_type        = var.type-ec2["data-engineering"]
    key_name             = var.key

    iam_instance_profile = data.aws_iam_role.EMR_EC2_DefaultRole.name


    user_data = file("./setup_instance_data_engineering.sh")

    root_block_device {
        volume_size           = 20
        volume_type           = "gp2"
        delete_on_termination = true
    }

    network_interface {
        network_interface_id = "${aws_network_interface.ntw-interface-ec2-data-engineering-prod.id}"
        device_index         = 0
    }

    tags = {
        Name        = "data-engineering-prod"
        Terraform   = "true"
        Environment = "prod"
    }

    depends_on = [aws_subnet.subnet-criminix-public-us-east-1, aws_network_interface.ntw-interface-ec2-data-engineering-prod]
}

resource "aws_network_interface" "ntw-interface-ec2-data-engineering-prod" {
    subnet_id   = "${aws_subnet.subnet-criminix-public-us-east-1.id}"

    tags = {
        Name        = "network_interface-data-engineering"
        Terraform   = "true"
        Environment = "prod"
    }
}

resource "aws_network_interface_sg_attachment" "sg-attach-data-engineering-web" {
  security_group_id    = aws_security_group.allow-sg-web.id
  network_interface_id = aws_network_interface.ntw-interface-ec2-data-engineering-prod.id
}

resource "aws_network_interface_sg_attachment" "sg-attach-data-engineering-ssh" {
  security_group_id    = aws_security_group.allow-sg-ssh.id
  network_interface_id = aws_network_interface.ntw-interface-ec2-data-engineering-prod.id
}

# Instância para o Backend, Web e DB
resource "aws_instance" "application-prod" {
    ami                  = var.amis["us-east-1"]
    instance_type        = var.type-ec2["application"]
    key_name             = var.key

    iam_instance_profile = data.aws_iam_role.EMR_EC2_DefaultRole.name



    user_data = file("./setup_instance_web.sh")

    root_block_device {
        volume_size           = 20
        volume_type           = "gp2"
        delete_on_termination = true
    }

    network_interface {
        network_interface_id = "${aws_network_interface.ntw-interface-ec2-application-prod.id}"
        device_index         = 0
    }

    tags = {
        Name        = "application-prod"
        Terraform   = "true"
        Environment = "prod"
    }

    depends_on = [aws_subnet.subnet-criminix-public-us-east-1, aws_network_interface.ntw-interface-ec2-application-prod]
}

resource "aws_network_interface" "ntw-interface-ec2-application-prod" {
    subnet_id   = "${aws_subnet.subnet-criminix-public-us-east-1.id}"

    tags = {
        Name        = "network_interface-application"
        Terraform   = "true"
        Environment = "prod"
    }
}

resource "aws_network_interface_sg_attachment" "sg-attach-application-web-prod" {
  security_group_id    = aws_security_group.allow-sg-web.id
  network_interface_id = aws_network_interface.ntw-interface-ec2-application-prod.id
}

resource "aws_network_interface_sg_attachment" "sg-attach-application-ssh-prod" {
  security_group_id    = aws_security_group.allow-sg-ssh.id
  network_interface_id = aws_network_interface.ntw-interface-ec2-application-prod.id
}
