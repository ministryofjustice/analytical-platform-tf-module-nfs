

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_ami" "occm_ami" {
  filter {
    name   = "name"
    values = ["OnCommand_Cloud_Manager_*"]
  }

  most_recent = true
  owners      = ["679593333241"]
}

resource "aws_instance" "occm" {
  ami                         = data.aws_ami.occm_ami.id
  instance_type               = var.instance_type
  key_name                    = var.key_pair
  vpc_security_group_ids      = [aws_security_group.sec_grp.id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_role.role.name

  tags = {
    Name          = var.name
    business-unit = var.tags["business-unit"]
    application   = var.tags["application"]
    is-production = var.tags["is-production"]
    owner         = var.tags["owner"]
  }

  provisioner "local-exec" {
    command = <<EOF
      ansible-playbook '${var.ansible_provision_file}' --extra-vars 'occm_ip=${self.public_ip} \
                                                                    client_id=${var.client_id} \
                                                                    auth0_domain=${var.auth0_domain} \
                                                                    refToken=${var.refresh_token} \
                                                                    portalUserName=${var.portal_user_name}'
    EOF
  }
}

resource "aws_eip" "occm" {
  vpc = true
}

resource "aws_eip_association" "occm_example" {
  allocation_id = "${aws_eip.occm.id}"
  instance_id = "${aws_instance.occm.id}"
}
