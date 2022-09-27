# main.tf

resource "local_file" "teksti_tiedosto" {
    filename    = "tiedosto.txt"
    content     = "Teksti joka tiedostoon lisätään"
}