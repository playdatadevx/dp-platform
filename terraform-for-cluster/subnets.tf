data "aws_subnet" "public_sn_a" {
  id = "${var.public_sn_a}"
}
data "aws_subnet" "public_sn_b" {
  id = "${var.public_sn_b}"
}
data "aws_subnet" "public_sn_c" {
  id = "${var.public_sn_c}"
}
data "aws_subnet" "private_sn_a" {
  id = "${var.private_sn_a}"
}
data "aws_subnet" "private_sn_b" {
  id = "${var.private_sn_b}"
}
data "aws_subnet" "private_sn_c" {
  id = "${var.private_sn_c}"
}