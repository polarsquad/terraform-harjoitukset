# 1. Harjoitus - Terraformin käyttöönotto

Ennen kuin ensimmäistäkään "koodinpätkää" on kirjoitettu, on hyvä tarkistaa mikä versio Terraformista on asennettuna koneelle, jolla terraformia aiotaan suorittaa.

*Terraform version tarkistaminen*  

```sh
$ terraform --version
Terraform v1.3.0
on darwin_arm64
```

Tässä tapauksessa koneella on asennettuna Terraformista versio 1.3.0.
Jos komento ei toimi, niin tarkista että terraform on asennettu oikein. Ohjeet löytyvät [täältä](https://learn.hashicorp.com/tutorials/terraform/install-cli)

## Ensimmäisen koodipätkän kirjoittaminen
Terraform määritykset kirjoitetaan `.tf` pääteellä varustettuihin tiedostoihin.  
Luodaan siis ensimmäinen terraform-tiedosto, johon määritetään seuraava sisältö.

```yaml
resource "local_file" "tiedosto1" {
  filename  = "tiedosto.txt"
  content   = "Tiedostoon tallennettavaa tekstiä."
}
```

Oheinen resurssi luo hakemistoon, jossa terraform ajetaan, tiedoston nimeltä _tiedosto.txt_, jonka sisällöksi asetetaan `content` parametrin sisältämä teksti.  
Ennen kuin resurssia voidaan kuitenkaan luoda, pitää terraformin osalta ympäristö alustaa käyttöön, joka tapahtuu `terraform init` komennolla.

```sh
$ terraform init
Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/local...
- Installing hashicorp/local v2.2.3...
- Installed hashicorp/local v2.2.3 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!
```

Nyt jos tulostamme uudestaan terraformin version, samassa hakemistossa missä `terraform init` on suoritettu, näyttää tämän tuloste seuraavalta
```sh
$ terraform --version
Terraform v1.3.0
on darwin_arm64
+ provider registry.terraform.io/hashicorp/local v2.2.3
```  
Nyt ympäristö on alustettu, ja ollaan valmiita varsinaisesti käyttämään terraformia resurssien luomiseen.
Huomioitavaa on että terraform on init komennon osana asentanut myös yhden providerin, joka näkyy yllä olevassa tulosteessa.
Tämä johtuu siitä, että itse terraform CLI ei itsessään omaa varsinaisesti resurssien luomiseen toiminnallisuuksia, vaan mahdollistaa ainoastaan terraformin perus toiminnallisuudet. Tämän johdosta terraformin kanssa käytetään käytännössä aina erillisiä providereita, joiden avulla lisätään tarvitsemamme toiminnot.  
*Local* provideriin liittyvä dokumentaatio on nähtävissä Terraform Registryn kautta, ja tätä voi tarkastella osoitteessa: <https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file>

## Ensimmäisen resurssin luominen
Avataan siis uudestaan editoriin `main.tf` tiedosto, ja lisätään sinne ensimmäinen resurssin määritys.
```yaml
## main.tf
resource "local_file" "teksti_tiedosto" {
    filename    = "tiedosto.txt"
    content     = "Teksti joka tiedostoon lisätään"
}
```

Tarkastellessamme yllä olevaa resurssi määritystä, voidaan siitä huomioida eri ominaisuuksia.  
`"local_file"` määritys määrittää millaista resurssia olemme luomassa. Joka tässä tapauksessa on paikallinen tiedosto.  
`"teksti_tiedosto"` on resurssin nimi, jolla nimellä terraform sen tuntee resurssina.  
Resurssi *local_file* tarvitsee toimiakseen myös määritteitä, jotta resurssi voidaan luoda.  
Kyseinen resurssityyppi vaatii toimiakseen vähintään seuraavat parametrit:
`filename` määrittää tiedoston nimen.  
`content` parametrin sisältämä teksti tallennetaan luotavaan tiedostoon.
Terraform-dokumentaatiosta voit aina tarkistaa resursseihin tarvittavat vaaditut (required) parametrit.

Tämän jälkeen voidaan siirtyä eteenpäin terraform workflowssa, ja katsoa mitä tämä määrittely olisi tekemässä, mikäli se ajetaan. Vaihetta kutsutaan myös ns. *dry-run* vaiheeksi.
```sh
$ terraform plan
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # local_file.teksti_tiedosto will be created
  + resource "local_file" "teksti_tiedosto" {
      + content              = "Teksti joka tiedostoon lisätään"
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "tiedosto.txt"
      + id                   = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```
Komennon suorittamisen jälkeen, terraform näyttää mitä se tekisi. Huomioitavaa on myös, että vaikka määritimme vain kaksi parametria resurssille, tallentaa terraform resurssista siitä huolimatta myös muita tietoja. Osan näistä voisimme määrittää itse, mutta `id` parametri on terraformin sisäiseen toimintaan liittyvä arvo, jolla se tunnistaa luodut resurssit.  
Seuraavaksi voidaan myös luoda tämä resurssi. Annetaan siis `terraform apply` komento, ja mikäli määritykset ovat oikein, kysyy se seuraavaksi vahvistamaan resurssien luomisen, vastataan siihen _yes_.
```sh
$ terraform apply
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # local_file.teksti_tiedosto will be created
  + resource "local_file" "teksti_tiedosto" {
      + content              = "Teksti joka tiedostoon lisätään"
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "tiedosto.txt"
      + id                   = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

local_file.teksti_tiedosto: Creating...
local_file.teksti_tiedosto: Creation complete after 0s [id=a02d1db9177f516fd144a8349b546c55774f0695]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
Näin olemme onnistuneesti luoneet ensimmäisen resurssin terraformin avulla.

Nyt on hyvä kokeilla itsenäisesti erinäisiä muutoksia luotuun resurssiin, ja katsoa miten ne vaikuttavat ajettaessa uudestaan `terraform plan | terraform apply --auto-approve`
Mahdollisia kokeiluita:
- tiedoston nimen muuttaminen
- tiedoston sisällön muokkaaminen suoraan tiedostoon
- tiedoston oikeuksien määrittäminen

**Resurssin tuhoaminen**  
Mikäli resurssia ei enää tarvita, voidaan ne tuhota käyttäen terraform komentoa `terraform destroy`. Komento noudattaa samaa tuttua tapaa, kuin resurssien luomisessa. Ensin näytetään mitään terraform olisi tekemässä, ja hyväksynnän jälkeen se suorittaa resurssien tuhoamisen.
```sh
$ terraform destroy

local_file.teksti_tiedosto: Refreshing state... [id=a02d1db9177f516fd144a8349b546c55774f0695]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # local_file.teksti_tiedosto will be destroyed
  - resource "local_file" "teksti_tiedosto" {
      - content              = "Teksti joka tiedostoon lisätään" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "tiedosto.txt" -> null
      - id                   = "a02d1db9177f516fd144a8349b546c55774f0695" -> null
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

local_file.teksti_tiedosto: Destroying... [id=a02d1db9177f516fd144a8349b546c55774f0695]
local_file.teksti_tiedosto: Destruction complete after 0s

Destroy complete! Resources: 1 destroyed.
```

> ### Näin olemme onnistuneesti tehneet seuraavaa:
>- ottaneet terraform CLI työkalun käyttöön
>- ottaneet käyttöön ensimmäisen määritystiedoston
>- ottaneet käyttöön providerin
>- luoneet ja poistaneet ensimmäisen resurssin