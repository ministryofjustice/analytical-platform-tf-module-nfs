output "ids" {
  description = "List of IDs of instances"
  value       = "${element(concat(aws_instance.occm.*.id, list("")), 0)}"
}

output "ip" {
  description = "List of IPs of instances"
  value       = "${aws_eip.occm.public_ip}"
}

output "url" {
  description = "URL of instance"
  value       = "${aws_route53_record.occm.name}"
}

output "internal_url" {
  description = "Internal URL of instance"
  value       = "${aws_route53_record.occm_nfs.name}"
}
