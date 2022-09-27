# main.tf

resource "local_file" "tiedosto" {
    filename = "teksti.txt"
    content  = "Jotain sisältöä vaan"
}

resource "fakewebservices_vpc" "verkko" {
    name       = "vpc"
    # name = "vpc-${var.nimi}"
    cidr_block = "10.100.0.0/24"
}

resource "fakewebservices_server" "serveri" {
    name = "server"
    # name = "server-${var.nimi}"
    type = "web"
    vpc  = "vpc"
    # vpc = fakewebservices_vpc.verkko.name
}