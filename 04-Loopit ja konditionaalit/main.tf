variable "lista" {
    default = ["Eka", "Toka", "Kolmas"]
}

variable "maara" {
    default = 5
}

variable "tyhja" {
    default = ""
}

# Looppi määrän perusteella
resource "local_file" "maara" {
    count = var.maara
    filename = "teksti${count.index}.txt"
    content = "Tekstiä vaan"
}

# Looppi jonkin muuttujan perusteella
resource "local_file" "looppi" {
    for_each = toset(var.lista)
    filename = "looppi_${each.value}.txt"
    content = "Tekstiä vaan"
}

# IF/ELSE esimerkki
resource "local_file" "jos_ehka" {
    filename = "jos.txt"
    content = (var.tyhja == "" ? "Olihan se tyhjä" : var.tyhja)
}