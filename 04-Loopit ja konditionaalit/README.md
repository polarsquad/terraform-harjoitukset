# Loopit ja IF/ELSE

Jotta voidaan edistyneemmin ja ehdollisemmin luoda esim. resursseja tai käsitellä tietoa, tarvitaan niitä varten myös looppeja ja if/else mahdollisuuksia.  
Terraformista nämä pöytyvätkin, ja ovat oheisessa esimerkissä lyhyesti.  

## Loopit
Terraformissa on pääasiassa kaksi mahdollista tapaa suorittaa looppeja.  
Toinen näistä on `count` toiminto, ja toinen on `for_each` toiminto.  

`count = 4` suorittaa loopin numeraalisen tiedon perusteella. Numeraalinen tieto voidaan antaa sille suoraan numerona, tai se voi olla jostain muuttujasta generoitu, esim. viisi tietuetta sisältävästä listasta `count = ["Eka", "Toka", "Kolmas"] # = 3`.  
`count` toimintoa käytettäessä, voidaan loopin sisällä käyttää hyödyksi tietoa, monesko suoritus kerta loopista on menossa, tähän arvoon voidaan viitata käyttämällä muuttujaa `count.index`.

`for_each = toset(var.lista)` toteutus suorittaa listan sisältävän muuttujan perusteella loopin. Lista pitää kuitenkin muuntaa set muuttujaksi ensin, jotta for_each pystyy sen ottamaan vastaan. Erona `count` toimintoon nähden on se, että loopin sisällä voidaan hyödyntää loopin alkulähteeksi annetun tietueen tietoja, joihin viitataan käyttämällä muuttujaa `each.value`.