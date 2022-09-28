variable "tiedoston_kansio" {
    description = "Hakemisto johon tiedosto tallennetaan"
    default     = "temp_kansio/"
}

variable "tiedoston_nimi" {
    description = "Tiedostolle annettava nimi"
    default = "tiedosto.txt"
    type        = string
}

variable "tiedoston_teksti" {
    description = "Tiedostoon tallennettava teksti"
    default = ""
    # default       = "Hello from tiedosto."
    nullable = true
}