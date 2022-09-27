# 2. Harjoitus - Providers

Kuten ensimmäisessä tehtävässä huomattiin, luotaessa resursseja käyttää näihin terraform aina providereita, jotka käytännössä resurssien luomiseen tarvittavat toiminnallisuudet tarjoavat.  

Määrittäessämme varsinaisesti resusseja ja kokonaisua ympäristöjä terraformin avulla, on monesti käytössä myös useita providereita.  
Yksi merkittävä seikka providereiden käyttöön otossa, on niiden versioiden hallinta. Etenkin kun terraformin avulla luodaan tuotanto ympäristöjä, on tärkeää ainakin jollain tarkkuudella määrittää versiot, joita käytetään.  
Alla näkyy esimerkki määritys, jossa määritellään tarvitsemamme `local` provider. Luo siis tiedosto `main.tf` ja lisää alla näkyvä määritys tiedostoon.

```yaml
## main.tf
terraform {
    # Lisätä tarvitsemamme providerit
    required_providers {
        local = {
          source = "hashicorp/local"
          version = "2.2.0"
        }
    }
}
```

Aina kun määrityksiin lisätään tai tehdään mitään muutoksia `terraform {}` blockiin, on muutosten jälkeen ajettava aina `terraform init` komento. Mikäli komentoa ei ajeta, ei muut komennot toimi, vaan ne antavat virheilmoituksen, ja kehoittavat ajamaan uudestaan init komennon.

```sh
$ terraform init
Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/local...
- Installing hashicorp/local v2.2.0...
- Installed hashicorp/local v2.2.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

```
Nyt jos tulostamme uudestaan terraformin version, näyttää tämän tuloste seuraavalta
```sh
$ terraform --version
Terraform v1.3.0
on darwin_arm64
+ provider registry.terraform.io/hashicorp/local v2.2.0
```  
Version komennon avulla näemme, mitä providerseja on asennettuna.  
Providerseja voidaan tarkastella myös komennon `terraform providers` avulla, joka listaa kaikki providerit, sekä niiden asennettavan version, mitkä kyseisessä kansiossa olevat terraformin määrittely tiedostot edellyttävät.  

`terraform init` komennon myötä on hakemistoon tullut lisää tiedostoja ja hakemisto.
- `.terraform` niminen hakemisto sisältää providerin tarvitsemat tiedostot, joissa sen sisältämät toiminnallisuudet ovat toteutettu
- `.terraform.lock.hcl` tiedosto, joka sisältää tietoja mm. määritetyistä providereista sekä erityisesti niiden versiosta. Tiedostoa voi tarkastella esim. tekstieditorilla.

**Version määritystä**  
Käytettävän providerin versio on hyvä määrittää tiettyyn versioon, joka yleensä on providerin versio, jolla alkujaan on omaa terraformin avulla luotavia resursseja alettu tekemään. Providerit päivittyvät melko tiheästi, ja päivitykset voivat tuota muutoksia, jotka rikkovat itsemme tekemät määritykset resurssien luomiseksi. Tämän välttämiseksi on providerin versio hyvä määrittää sellaiseksi, jonka tiedämme toimivan meidän tarkoituksessamme.  

Hetkelle jolloin nämä ohjeet on kirjoitettu, on `local` providerin uusin versio `v.2.2.3`. Muutetaan se siis `main.tf`tiedoston sisältämään määritykseen.  
- muuta version määritys seuraavaksi `version = "2.2.3"`
- suorita `terraform init` komento uudestaan

Onnistuiko `local` providerin päivittäminen?

Mikäli provideria halutaan päivittää, täytyy se tehdä tietoisesti, josta syystä terraform ei automaattisesti ota käyttöön providerin määrityksessä olevaa versiosta, vaan päivittäminen pitää tehdä lisäämällä init komentoon lisä valitsin. Päivitettäessä providereita, pitää käyttää komentoa `terraform init -upgrade`. Nyt ajaessasi tuon komennon, `local` provider päivittyy määrittämäämme versioon v.2.2.3.  
Etenkin tuotanto ympäristöjen luomiseen käytettävissä terraform määrityksissä, on monesti tapana määrittää korkein providerin versio, jolla toteutuksemme on todettu toimivan. Tämä määritys voidaan tehdä lisäämällä versio määritykseen lisää määritettä seuraavasti  
`version = "~>2.2.0, <3.0.0"`  
Kyseinen määritys määrittää version seuraavasti:
- `~>2.2.0` versio saa olla mikä tahansa ns. minor versio, versiosta 2.2, eli mikä tahansa versio sopii väliltä 2.2.0 - 2.2.xx.
- `<3.0.0` version pitää olla alle 3.0.0 versio.  
Tällä määrityksellä olemme voineet määrittää käytettävän version siten, että 2.2 versioon saa ottaa käyttään korjauksia, mutta pää versiota 2. ei saa päivittää seuraavaan pääversioon 3..

## Providerin konfigurointi
Moni provider tarvitsee konfigurointia, jotta se voidaan ottaa käyttöön. Tämä edellyttää lisä määrityksiä providerin osalta. Mikäli provider tarvitsee erillistä konfigurointia, tarvitsee määritykselle luoda oma osionsa terraform määritykseen.

```yaml
# main.tf
terraform {
    required_providers {
        local = {...}
        fakewebservices = {
            source = "hashicorp/fakewebservices"
            version = "0.2.3"
        }
    }
}

provider "fakewebservices" {
  # Configuration options
  token = "string"
}
    }
}
```
