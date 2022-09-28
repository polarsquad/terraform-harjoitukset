resource "local_file" "tiedosto" {
    filename = "${var.tiedoston_kansio}/${var.tiedoston_nimi}"
    content = (var.tiedoston_teksti == "" ? "Hello tiedostosta" : var.tiedoston_teksti)
    file_permission = "0777"
}