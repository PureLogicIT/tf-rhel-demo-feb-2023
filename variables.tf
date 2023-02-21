variable "prefix" {
  type = string
  default = "pl-rhel-demo"
  description = "Name used as prefix"
}
variable "region" {
  type = string
  default = "us-east-1"
}
variable "vpc_name" {
  type = string
  default = "game-vpc"
}
variable "subnet_name" {
  type = string
  default = "inside-subnet"
}
variable "sg_name" {
  type = string
  default = "inside-sg"
}
variable "sg_id" {
  type = string
  default = "sg-079c6c412b0f9a925"
}
variable "instance_type" {
  type = string
  default = "t3.medium"
}
variable "root_fs_size" {
  type = number
  default = 250
}
variable "root_fs_type" {
  type = string
  default = "gp3"
}
variable "home_ip" {
  type = string
  default = "173.177.76.238/32"
}
variable "rhel8_host_count" {
  type = number
  default = 1
}
variable "rhel9_host_count" {
  type = number
  default = 2
}
variable "rhel9_az" {
  type = string
  default = "us-east-1a"
}
variable "rhel8_az" {
  type = string
  default = "us-east-1b"
}
variable "key_pair" {
  type = string
  default = "justin"
}
