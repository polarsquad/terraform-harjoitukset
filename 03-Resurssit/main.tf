# main.tf

resource "local_file" "tiedosto" {
    filename = "teksti.txt"
    content  = "Jotain sisältöä vaan"
}

resource "fakewebservices_vpc" "verkko" {
    name       = "vpc"
    cidr_block = "10.100.1.0/24"
}

resource "fakewebservices_server" "serveri" {
    name = "server"
    type = "web"
    vpc  = "vpc"
}