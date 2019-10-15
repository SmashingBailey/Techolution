# This file allows you to establish your variables

variable "region" {
    default = "us-east-1"
}

variable "os" {
    default = "ubuntu"
}

variable "instance_type" {
    type = "string"
    default = "t2.micro"
}

variable "amis" {
    type = "map"
    default = {
    "ubuntu" = "ami-07d0cf3af28718ef8"
    "redhat" = "ami-0c322300a1dd5dc79"
    }   
}

variable "key_name" {
    type = "string"
    default = "bailey"
}

variable "ssh_private_key" {
    type = "string"
    default = "/home/bailey/Documents/development/cloud/aws/bailey.pem"
}