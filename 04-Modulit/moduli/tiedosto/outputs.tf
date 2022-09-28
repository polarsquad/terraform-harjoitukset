output "tiedoston_nimi" {
    value = local_file.tiedosto.filename
}

output "tiedoston_teksti" {
    value = local_file.tiedosto.content
}

output "tiedoston_oikeudet" {
    value = local_file.tiedosto.file_permission
}

output "hakemiston_oikeudet" {
    value = local_file.tiedosto.directory_permission
}