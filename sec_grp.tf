resource "aws_security_group" "sec_grp" {
  name   = var.name
  vpc_id = data.aws_vpc.selected.id

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    self        = true
    description = "Allows ONTAP instances to recieve sotfware updates from the Cloud Manager"
  }

  ingress {
    from_port = 443
    protocol  = "tcp"
    to_port   = 443

    cidr_blocks = var.cidr_blocks

    description = "Web and API access to Cloud Manager and ONTAP instances"
  }

  ingress {
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    self      = true

    cidr_blocks = var.cidr_blocks

    description = "SSH/Ansible access to Cloud Manager and ONTAP instances "
  }

  ingress {
    from_port   = 3000
    protocol    = "tcp"
    to_port     = 3000
    self        = true
    description = "NetAPP ONTAP gossip and HA"
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name          = var.name
    business-unit = var.tags["business-unit"]
    application   = var.tags["application"]
    is-production = var.tags["is-production"]
    owner         = var.tags["owner"]
  }
}
