locals {
  rules = {
    for rule in flatten(distinct(var.security_group_rules)) :
    format("%s-%s-%s-%s-%s-%s-%s-%s-%s-%s",
      rule.type,
      rule.protocol,
      rule.from_port,
      rule.to_port,
      lookup(rule, "cidr_blocks", null) == null ? "no_ipv4" : "ipv4",
      lookup(rule, "ipv6_cidr_blocks", null) == null ? "no_ipv6" : "ipv6",
      lookup(rule, "security_group_id", null) == null ? "no_ssg" : "ssg",
      lookup(rule, "prefix_list_ids", null) == null ? "no_pli" : "pli",
      lookup(rule, "self", null) == null ? "no_self" : "self",
      lookup(rule, "description", null) == null ? "no_desc" : md5(rule.description)
    ) => rule
  }
}

resource "aws_security_group" "default" {
  name  = "${var.name}-ec2"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "default" {
  for_each = local.rules

  security_group_id = aws_security_group.default.id
  type = each.value.type
  from_port = each.value.from_port
  to_port = each.value.to_port
  protocol = each.value.protocol
  cidr_blocks = lookup(each.value, "cidr_blocks", null)
  ipv6_cidr_blocks = lookup(each.value, "ipv6_cidr_blocks", null)
  prefix_list_ids = lookup(each.value, "prefix_list_ids", null)
  source_security_group_id = lookup(each.value, "source_security_group_id", null)
}
