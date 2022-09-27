# 2. Harjoitus - Muuttujat (variables)
Vaikka terraform ei olekaan varsinainen ohjelmointikieli, ei sitä voida tehokkaasti hyödyntää, ilman muuttujien käyttämistä.  

Terraform tukee useita erilaisia muuttujia, joita voidaan käyttää yhdistellen riippuen omien toteutuksien vaatimuksista.

**Muuttujan määrittely**

Luodaan ensin pari uutta resurssia fakewebservices providerin avulla. Lisää `main.tf` tiedostoon seuraavat resurssit. Voit itse määritellä haluamasi arvot resurssien parametreihin.

```yaml
# main.tf
...

resource "fakewebservices_vpc" "verkko" {
    name       = "vpc"
    cidr_block = "10.100.0.0/24"
}

resource "fakewebservices_server" "serveri" {
    name = "server"
    type = "web"
    vpc  = "vpc"
}

```

Palauta mieleen mitä komentoja tuli ajaa, jotta saat muutokset tehtyä.
Aja joko vaiheittain, ensin `terraform plan` ja sitten erikseen `terraform apply`, tai voit ajaa muutokset kerralla: `terraform plan | terraform apply --auto-approve`. Huomaa että toisen vaihtoehdon `--auto-approve` lisämääritys poistaa varmistuksen siitä haluatko tehdä muutokset jotka on tunnistettu.

Usein resursseja luodessa halutaan resursseihin nimeämiskäytäntö käyttöön. Yksi tapa toteuttaa tämä on luoda muuttuja, jota hyödynnetään resurssien määrittelyssä. Luo uusi tiedosto `variables.tf`. Lisää tiedostoon uusi muuttuja seuraavasti:

```yaml
# variables.tf

variable "nimi" {
    description = "Resurssien nimeämisessä käytettävä osa nimeä"
    type        = string
    default     = "feikki"
}
```

Tarkastelemalla tätä määritystä näemme muutamia asioita:
Loimme tällä kertaa `variable` blockin,  kun aikaisemmin olemme käyttäneet `resource` blockeja.
`"nimi"` määrittää muuttujan nimen terraformin sisällä, jonka avulla voimme referoida tätä muuttujaa terraform määrittelyssämme. 
Muuttujalle voidaan antaa `description` arvo, johon kuvataan mihin muuttujaa käytetään. 
`type` arvoksi annetaan muuttujan tyyppi esim. `string`, `number`, `bool` jne.
`default` määrittelee muuttujalle default-arvon, jota käytetään jollei muuttujalle anneta muuta arvoa terraform komentojen yhteydessä.

Otetaan muuttuja käyttöön resurssien määrittelyssä. Muuta `fakewebservices_vpc` resurssin `name` seuraavaan muotoon: `"vpc-${var.nimi}"`. `${}` syntaksi mahdollistaa muuttujan arvon tuomista osaksi merkkijonoa. Jos haluat käyttää pelkkää muuttujan arvoa nimessä,se onnistuu asettamalla `name = var.nimi`. Muuttujia käytettäessä niihin voidaan siis viitata syntaksilla `var.<muuttujan_nimi>`.

Toteuta muutokset vaadittavilla terraform komennoilla.

Nyt on hyvä kokeilla itsenäisesti muuttujia, ja katsoa miten ne vaikuttavat ajettaessa uudestaan `terraform plan | terraform apply --auto-approve`
Mahdollisia kokeiluita:
- luo uusi muuttuja ja aseta sille default arvo
- viittaa muuttujaan jostain resurssista

**Muuttujan antaminen komentoriviltä**

Jätin vaiheeseen kun tajusin et tää ei toimi, mut tähän siis viel nää osiot...

**Outputit**


> ### Näin olemme onnistuneesti tehneet seuraavaa:
>- muuttujien määrittely ja viittaaminen
>- muuttujan arvon syöttäminen komentoriviltä
>- outputtien määrittely
>- viitanneet toisen resurssin parametreihin