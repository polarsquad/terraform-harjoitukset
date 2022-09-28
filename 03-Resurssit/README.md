# 3. Harjoitus - Resurssit

Kun olemme määritelleet käytetävät providerit, pääsemme itse asiaan, eli resurssien luontiin. Nämä ovat ne määritykset, jotka vastaavat jollekin alustalle luotavaa resurssia, esimerkiksi virtuaalikonetta VMWaressa.

**Resurssien luominen**

Luodaan ensin pari uutta resurssia `fakewebservices` providerin avulla. Tutki providerin dokumentaatiota ja mitä resursseja sillä voidaan luoda: <https://registry.terraform.io/providers/hashicorp/fakewebservices/latest/docs>. Valitse sivulta `Documentation` ja vasemmasta valikosta sen jälkeen `Resources`. Huomaat, että tämä provider mahdollistaa neljän eri resurssin luomisen:
`fakewebservices_database`, `fakewebservices_load_balancer`, `fakewebservices_server` ja `fakewebservices_ vpc`. Tutki näitä eri resursseja ja mitä parametrejä niillä on. Jokaiselle resurssille löytyy sekä pakollisia (Required), että valinnaisia (Optional) parametreja.

Lisää `main.tf` tiedostoon seuraavat resurssit. Voit itse määritellä haluamasi arvot resurssien parametreihin.

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

Näistä määrittelyistä näet, että resurssi määritellään aina `resource` blokissa, sitten kerrotaan resurssin tyyppi, esim `"fakewebservices_vpc"` ja resurssin nimi Terraformin sisällä, esim. `"verkko"`. Lopuksi annetaan resurssin määrittelyyn vaadittavat parametrien arvot, esim. `name` ja `cidr_block`. 

Palauta mieleen mitä komentoja tuli ajaa, jotta saat yllä olevat muutokset tehtyä.

Aja  ensin `terraform plan` ja tutki millaiset resurssit tämä muutos luo. Aja sitten erikseen `terraform apply` ja hyväksy muutokset.

Jo luoduista resursseista nähdään, että yleisesti resurssin määrittely näyttää siis tältä:

```yaml
resource "<RESOURCE_TYPE>" "<RESOURCE_NAME>" {
    PARAMETER_1 = "stringvalue"
    PARAMETRI_2 = ...
    ...
}
```
Resurssin tyyppi vastaa aina jostain providerista löytyvää resurssia ja siihen vaadittavat määrittelyt saat aina tarkistettua terraform dokumentaatiosta kyseisen providerin `Resource` osiosta.

Nyt on hyvä kokeilla itsenäisesti resurssien luomista. Lisää siis yksi uusi resurssi `fakewebservices` providerin alta.

**Resurssin muokkaus**

Usein resurssin luomisen jälkeen meidän tarvitsee myös muokata luotuja resursseja. Kokeillaan miten erilaiset muutokset vaikuttavat luotuihin resursseihin. Muokataan tällä kertaa verkkoresurssia seuraavasti:

```yaml
# main.tf
...

resource "fakewebservices_vpc" "verkko" {
    name       = "vpc"
    cidr_block = "10.100.1.0/24"
}
...
```

Ajetaan sitten `terraform plan` ja tutkitaan muutoksia.

```
$ terraform plan

local_file.tiedosto: Refreshing state... [id=8acc162a0eb95c25f2ed1a429bac0aec72b08d0f]
fakewebservices_server.serveri: Refreshing state... [id=fakeserver-rZ7BaAZAs6h3yxfr]
fakewebservices_vpc.verkko: Refreshing state... [id=fakevpc-gDcJNk28TC8hQDVM]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  ~ update in-place

Terraform will perform the following actions:

  # fakewebservices_vpc.verkko will be updated in-place
  ~ resource "fakewebservices_vpc" "verkko" {
      ~ cidr_block = "10.100.0.0/24" -> "10.100.1.0/24"
        id         = "fakevpc-gDcJNk28TC8hQDVM"
        name       = "vpc"
    }

Plan: 0 to add, 1 to change, 0 to destroy.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── 

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```
Näemme että kyseinen muutos päivittää tämän resurssin lennossa. Kun teet muutoksia on myös mahdollista että muutos pakottaa resurssin uudelleen luonnin. Erityisesti näitä kannattaa pitää silmällä ja huomioida ne muutoksia tehdessä.

Kokeile tehdä itsenäisesti muutoksia eri parametreihin ja resursseihin ja tarkastele miten muutokset vaikuttavat resursseihin. Voit toteuttaa muutokset ajamalla `terraform apply`.

**Toiseen resurssiin viittaaminen**
