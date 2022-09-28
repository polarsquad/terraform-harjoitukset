# VMWare ja Terraform

Tässä kansiossa on kaksi esimerkki toteutusta, kuinka Terraformilla käsitellään VMWare ympäristöjä.  

*Tietojen hakeminen* kansiossa on yksinkertainen aloitukseen sopiva esimerkki toteutus, jonka avulla on helppo kokeilla että Terraformin provider saadaan konfigurointua käyttöön. Sekä että virtuaalin koneiden luomisessa yleisimmin käytettäviä data sourceja kyetään onnistuneesti löytämään. Huomaatkan, että tiedostossa `terraform.tfvars` on määritetty muuttujia mm. datacenterin, datastoren, jne tiedojen hakemiseen, jotka ovat edellytyksiä mm. virtuaali koneiden luomiselle.  

*VM Modulista* kansiossa on esimerkki toteutus itse rakennetusta terraform modulista, jolla luodaan templatesta käsin uusi Linux virtuaalipalvelin. Modulin tarkoitus on konkretisodia moduleiden ydin tarkoitusta, eli yksinkertaistaa sekä generalisoida resurssien luontia, joihin muutoin joututaan terraformin määrityksen tasolla määrittämään useita parametreja.  
```
├── linux_from_module
│   ├── main.tf
│   ├── providers.tf
│   ├── terraform.tfvars
│   └── variables.tf
└── modules
    └── linux_vm
        ├── main.tf
        ├── outputs.tf
        ├── providers.tf
        └── variables.tf
```
Ohessa olevasta kansiorakenteesta nähdään hieman tämän toteutuksen rakennetta.
Kansiossa `linux_from_template` on toteutus, joka käyttää `/modules/linux_vm` kansioon luotua modulia.

Modulien käytössä on huomiotavaa, että tässä tapauksessa provider `hashicorp/vsphere` on oltava määriteltynä kummassakin paikassa, niin määrityksessä josta modulia kutsutaa, kuin myös modulin määrityksessä. Erikseen on huomioita vielä se, että tässä tapauksessa kun provider edellyttää konfiguraatiota, niin providerin konfiguraatio on määritettynä ainoastaan modulia kutsuvassa päässä. Tässä tapauksessa providerin konfigurointi edellyttää mm. vSphere palvelimelle tarvittavan käyttäjätunnuksen ja salasanan valittämistä, niin näitä ei kuulu tehdä enää modulin toteutuksessa erikseen.