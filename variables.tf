variable "cidr_block" {
    default = "10.0.0.0/16"
}

variable "private_subnet" {
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet" {
    default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "ami" {
    default = {
        Prod = "ami-022e1a32d3f742bd8"
    }
}

variable "instance_type"{
    default = {
        Prod = "t2.micro"
        Nprod = "t2.small"
    }
}

variable "key_name" {
    default = "shiva-test"
}