data "aws_vpc_endpoint_service" "s3" {
  service = "s3"
}

data "aws_route_tables" "route_tables" {
  vpc_id = data.aws_vpc.selected.id
}

resource "aws_vpc_endpoint" "s3" {
  service_name = data.aws_vpc_endpoint_service.s3.service_name
  vpc_id       = data.aws_vpc.selected.id
}

resource "aws_vpc_endpoint_route_table_association" "s3" {
  count           = length(data.aws_route_tables.route_tables.ids)
  route_table_id  = tolist(data.aws_route_tables.route_tables.ids)[count.index]
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}
