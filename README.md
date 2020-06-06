# Statistička analiza skupa podataka Titanik

![titanic_image](https://i.postimg.cc/rmDdgGSF/Titanic.jpg)

## Uvod

15.4.1912 globalno smatrani "nepotopopivi" brod Titanik je potonuo nakon sudara sa ledenim bregom. Na brodu nije bilo dovoljno čamaca za spasavanje, tako da je zajedno sa sobom Titanik odneo oko 1500 života.  

Element sreće je definitivno uticao na to ko od putnika će preživeti, a ko ne.  
Međutim, mi smatramo da su postojali neki dodatni faktori koji su uticali na to ko od putnika ce biti stavljen na brod za spasavanje i ovim seminarskim radom želimo da utvrdimo šta je to uticalo na odluku da li će osoba preživeti ili ne. 


## Spajanje podataka

Titanik skup podataka je originalno namenjen za vežbanje tehnika istrazivanja podataka, te se samim tim sastoji iz 2 dela:
- *Trening deo*
- *Test deo*

Pošto nas trenutno nije interesovala ta podela, spojili smo trening i test podatke u jedan skup, koji ima 1309 kolona.

## Opis podataka

U nastavku je dato ime i opis svakog atributa u skupu:

<table>
  <tr>
    <th>Atribut</th>
    <th>Opis</th> 
    <th>Vrednosti</th>
  </tr>
  <tr>
    <td>Survival</td>
    <td>Da li je osoba preživela potonuće</td>
    <td>0 / 1</td>
  </tr>
  <tr>
    <td>Pclass</td>
    <td>Klasa putnika</td>
    <td>1- prva, 2 - druga, 3 - treca</td>
  </tr>
  <tr>
    <td>Sex</td>
    <td>Pol</td>
    <td>muški / ženski</td>
  </tr>
  <tr>
    <td>Age</td>
    <td>Godine</td>
    <td>0 - 81</td>
  </tr>
  <tr>
    <td>Sibsp</td>
    <td>Broj braće i sestara / supružnika na brodu</td>
    <td>0 - 8</td>
  </tr>
  <tr>
    <td>Parch</td>
    <td>Broj roditelja / dece brodu</td>
    <td>0 - 8</td>
  </tr>
  <tr>
    <td>Ticket</td>
    <td>Broj karte</td>
    <td></td>
  </tr>
  <tr>
    <td>Fare</td>
    <td>Cena karte</td>
    <td>0 - 512.3292</td>
  </tr>
  <tr>
    <td>Cabin</td>
    <td>Broj kabine</td>
    <td></td>
  </tr>
  <tr>
    <td>Embarked</td>
    <td>Luka iz koje se putnik ukrcao na brod</td>
    <td>C - Cherbourg, Q - Queenstown, S - Southampton</td>
  </tr>
  <tr>
    <td>Name</td>
    <td>Ime i prezime putnika</td>
    <td></td>
  </tr>  
</table>

## Preprocesiranje podataka

Kako smo hteli da umesto samo kolone *Name* imamo odvojeno ime i prezime, početni podaci su obrađeni pomoću fajla `data_extractor.py` gde je starta kolona *Name* uklonjena i na osnovu nje su napravljene 2 nove kolone:
  - *Name* - Samo ime osobe
  - *Surname* - Samo prezime osobe

Tako dobijene podatke smo dalje obradili kako bismo uklonili nedostajuće vrednsti

## Rad sa nedostajućim vrednostima

Tabela sa brojem nedostajućih vrednosti:

<table>
  <tr>
    <th>Kolona</th>
    <th>Broj nedostajucih vrednosti</th> 
  </tr>
  <tr>
    <td>Survived</td>
    <td>0</td> 
  </tr>
  <tr>
    <td>PClass</td>
    <td>0</td> 
  </tr>
  <tr>
    <td>Sex</td>
    <td>0</td> 
  </tr>
  <tr>
    <td>Age</td>
    <td>263</td> 
  </tr>
  <tr>
    <td>SibSp</td>
    <td>0</td> 
  </tr>
  <tr>
    <td>Parch</td>
    <td>0</td> 
  </tr>
  <tr>
    <td>Ticket</td>
    <td>0</td> 
  </tr>
  <tr>
    <td>Fare</td>
    <td>1</td> 
  </tr>
  <tr>
    <td>Cabin</td>
    <td>1014</td> 
  </tr>
  <tr>
    <td>Embarked</td>
    <td>2</td> 
  </tr>
  <tr>
    <td>Name</td>
    <td>0</td> 
  </tr>
</table>


Vidimo da polja *Age*, *Fare*, *Cabin*, *Embarked* imaju nedostajuće vrednosti i u nastavku je dat opis, kako smo rešavali taj problem za svaku od klasa pojedinačno

### Nedostajuće vrednosti za godine

Iz datog skupa, vidimo da *Age* atribut ima 263 nedostajuće vrednosti. Da bismo popunili te vrednosti, koristili smo *mice* paket iz R-a, čija je uloga rad sa nedostajućim vrednostima. Naredna slika pokazuje statistike za *Age* atribut, pre i posle popunjavanja:

![plot_age_impute_table](https://i.postimg.cc/W4pB7f5q/age-impute.png)

Vidimo da jedina statistika po kojoj se razlikuju ove 2 pregleda je *Mean* i to za 0.08, što je prilično dobro, tako da smo zadovoljni ovom aproksimacijom.

### Nedostajuće vrednosti za kabinu

Ovde je situacija gora nego za prehnodni slucaj jer *Cabin* atribut ima 1014
nedostajućih vrednosti, tako da smo ovde zaključili da nema smisla raditi aproksimaciju nedostajuće vrednosti.

### Nedostajuće vrednosti za cenu karte

Iz tabele, zaključujemo da samo jednoj osobi fali infromacija o ceni karte. Ta osoba je:

<table>
  <tr>
    <th>Survived</th> 
    <th>Pclass</th>
    <th>Sex</th> 
    <th>Age</th>
    <th>SibSp</th> 
    <th>Parch</th>
    <th>Ticket</th> 
    <th>Fare</th>
    <th>Cabin</th> 
    <th>Embarked</th>
    <th>Name</th> 
  </tr>
  <tr>
    <td><b>0</b></td> 
    <td><b>3</b></td>
    <td><b>male</b></td> 
    <td>60.5</td>
    <td>0</td> 
    <td>0</td>
    <td>3701</td> 
    <td>NA</td>
    <td>NA</td> 
    <td><b>S</b></td>
    <td>Thomas Storey</td> 
  </tr>
</table>

Iz date tabele zakljucujemo 4 bitne stvari:
<ul>
    <li> Osoba je bila muško </li>
    <li> Pripadala je trećoj klasi </li>
    <li> Nije preživela potonuće </li>
    <li> Ukrcala se u Southampton-u </li>
</ul>

Zato smo odlučili da cenu karte ove osobe aproksimiramo srednjom vrednosti cene karata svih osoba muškog pola, treće klase, koje nisu preživele potonuće i ukrcale su se iz luke Southampton.

### Nedostajuće vrednosti za luku u kojoj su se putnici ukrcali na brod

Ovde je situacija interesantnija. Pogledajmo tabelu:

<table>
  <tr>
    <th>Survived</th> 
    <th>Pclass</th>
    <th>Sex</th> 
    <th>Age</th>
    <th>SibSp</th> 
    <th>Parch</th>
    <th>Ticket</th> 
    <th>Fare</th>
    <th>Cabin</th> 
    <th>Embarked</th>
    <th>Name</th> 
  </tr>
  <tr>
    <td><b>1</b></td> 
    <td><b>1</b></td>
    <td><b>female</b></td> 
    <td>38</td>
    <td>0</td> 
    <td>0</td>
    <td>113572</td> 
    <td><b>80</b></td>
    <td>B28</td> 
    <td>NA</td>
    <td>Amelie Icard</td> 
  </tr>
  <tr>
    <td><b>1</b></td> 
    <td><b>1</b></td>
    <td><b>female</b></td> 
    <td>62</td>
    <td>0</td> 
    <td>0</td>
    <td>113572</td> 
    <td><b>80</b></td>
    <td>B28</td> 
    <td>NA</td>
    <td>Stone, Mrs. George Nelson (Martha Evelyn)
</td> 
  </tr>
</table>

Iz tabele zaključujemo: 
<ul>
<li>U pitanju su bile osobe ženskog pola</li>
<li>Delile su kabinu</li>
<li>Obe su preživele</li>
<li>Klasa putnika je bila ista (sto je logično, jer su delile kabinu)</li>
</ul>  

Ovde smo primenili strategiju računanja medijanu cene karata za putnica iz luka Cherbourg, Queenstown i Southampton, prve klase, koje su preživele. 
Vredonosti medijana su:

- 78.85 za Southampton
- 83.1583 za Cherbourg
- 90 za Queenstown

Zbog toga smo se odlučili da nedostajućim vrednostima za luku ukrcavanja dodelimo vrednost S, jer je najbliža stvarnoj ceni plaćene karte putnica.


## Obrada podataka

U ovom delu su prikazane razne podele i statistike koje smo radili nad podacima.

### Odnos između imena putnika i šanse da su preživeli

Ovde smo želeli da proverimo da li postoji nekakva veza između imena koje je imao putnik i činjenice da li je preživeo. Na grafiku 
ispod su prikazana imena za koja je bilo bar 5 putnika na brodu, kao i procenat preživelih putnika:

![plot_name_vs_survived](https://i.postimg.cc/1XnzGhvZ/plot-name-vs-survived.png)

Interesantna stvar koju vidimo ovde je da su sve osobe sa imenom Kejt, Katarina ili Elizabeta preživele, dok je jedini slučaj gde niko nije preživeo bio kod osoba sa imenom Patrik.


### Odnos između cene karte i mesta gde ukrcavanja

Želeli smo da vidimo da li postoji nekakva razlika u ceni karte u zavisnosti od toga na kom mestu su se putnici ukrcali. Na grafiku ispod možemo da vidimo sve cene karata koje koštaju do 300 funti u sva 3 mesta. Limit od 300 funti je namerno postavljen, jer je bilo veoma malo karata koje su koštale više od 300 funti, pa je zbog lepšeg prikaza odlučeno da se te vrednosti ne gledaju.

![plot_embarked_vs_fare](https://i.postimg.cc/CdpwbZZj/plot-embarked-vs-fare.png)

Sa slike možemo videti da je raspodela cene karata za Cherbourg i Southampton jako slična, odnosno da su podaci gušće raspoređeni u intervalu [0, 100], ređe u intervalu [100, 200] i baš retko za cenu karte koja je veća od 200. Queenstown sa druge strane ima drugačiju raspodelu, pre svega jer se dosta manji broj putnika ukrcao iz ove luke.

### Test zavisnosti između luke ukrcavanja i preživljavanja

Kad napravimo tabelu, koja pokazuje broj prezivelih / preminulih po luci sa koje su se ukrcali, dobijamo sledeće podatke:

<table>
  <tr>
    <th></th>
    <th>C</th> 
    <th>Q</th>
    <th>S</th>  
  </tr>
  <tr>
    <th>0</th>
    <td>137</td>
    <td>69</td>
    <td>609</td>
  </tr>
  <tr>
    <th>1</th>
    <td>133</td>
    <td>54</td>
    <td>307</td>
  </tr>
</table>

Verovatnoće preživljavanja za svaku luku su:  
- Cherbourg: 0.49
- Queenstown: 0.43
- Southampton: 0.33

Odavde bi se moglo zaključiti da luka iz koje se osoba ukrcala utiče na verovatnoću njenog preživljavanja.  
Da bismo potvrdili tu hipotezu, napravili smo test nezavisnosti izmedju mesta ukrcavanja osobe i toga da li je ona preživela, odnosno:

- *H0* - luka ukrcavanja i verovatnoća preživljavanja su nezavisne veličine
- *H1* - luka ukrcavanja i verovatnoća preživljavanja su zavisne veličine

Iz fajla `Titanik.R` prilikom pokretanja funkcije  `test_survived_dependant_on_embarked()` dobijamo da je vrednost *test statistike*
24.19, a *kritične sekcije* 9.21.  
Ovim rezultatom potvrđujemo da je verovatnoća preživljavanja osobe zavisila od luke iz koje se ukrcala na brod, odnosno obaramo nultu hipotezu.

### Uticaj pola na preživljavanje

Želeli smo da proverimo da li pol ima uticaja na preživljavanje. Početna pretpostavka je bila da će imati, jer se zna da su prednost u čamcima dobijali žene i deca. Sa sledećeg grafika vidimo da pretpostavka jeste tačna:

![plot_female_vs_male_survival_frequency](https://i.postimg.cc/0yMNMJVH/plot-female-vs-male-survival-frequency.png)

Još jedan grafik koji prikazuje preživele i umrle:

![plot_sex_vs_age_survived](https://i.postimg.cc/YqmcQfwg/plot-sex-vs-age-survived.png)

Odavde se može primetiti da je najveći procenat osoba muškog pola koji je preživeo zapravo bio u dečijem uzrastu, što se takođe uklapa sa činjenicom da su u čamcima sa spašavanje prednost imali žene i deca.

#### Uticaj godina putnika na preživljavanje

Ovim testom želimo da proverimo da li je tačno da su godine starosti nekako uticale na šansu za preživljavanje.  
Pošto su godine numerički, neprekidni atribut, mi smo sve putnike na brodu podelili u sledeće kategorije, prema godinama:  
- Kategorija 1: putnici mlađi od 4 godine
- Kategorija 2: putnici između 4 i 12 godina
- Kategorija 3: putnici između 12 i 21 godinu
- Kategorija 4: putnici između 21 i 35 godina
- Kategorija 5: putnici između 35 i 50 godina
- Kategorija 6: putnici između 50 i 80 godina
- Kategorija 7: putnici stariji od 80 godina

Tabelarni prikaz podele izgleda ovako:

<table>
  <tr>
    <th></th>
    <th>1</th> 
    <th>2</th>
    <th>3</th>  
    <th>4</th>
    <th>5</th> 
    <th>6</th>
    <th>7</th>
  </tr>
  <tr>
    <th>0</th>
    <td>14</td>
    <td>28</td>
    <td>93</td>
    <td>287</td>
    <td>140</td>
    <td>67</td>
    <td>0</td>
  </tr>
  <tr>
    <th>1</th>
    <td>27</td>
    <td>22</td>
    <td>65</td>
    <td>165</td>
    <td>95</td>
    <td>52</td>
    <td>1</td>
  </tr>
</table>

Hipoteze:  
- *H0* - Godine putnika i šansa za preživljavanjem su nezavisne veličine
- *H1* - Godine putnika i šansa za preživljavanjem su zavisne veličine

Primećujemo da su prva i sedma kategorija imale veliku šansu za preživljavanjem, dok je cetvrta imala jako malu šansu.  
Prilikom pokretanja funkcije `test_survived_dependant_on_age()` dobijamo da je 
vrednost *test statistike* 15.76, a vrednost *konstante za kritičnu sekciju* je 16.81. Odavde zaključujemo da **prema ovoj podeli kategorija za godine, godine nisu uticale na šansu za preživljavanje.** 

### Uticaj putničke klase na preživljavanje
Tabelarni prikaz koja pokazuje raspodelu putničke klase prema tome da li je osoba preživela:

<table>
  <tr>
    <th></th>
    <th>1</th> 
    <th>2</th>
    <th>3</th>  
  </tr>
  <tr>
    <th>0</th>
    <td>137</td>
    <td>160</td>
    <td>518</td>
  </tr>
  <tr>
    <th>1</th>
    <td>186</td>
    <td>117</td>
    <td>191</td>
  </tr>
</table>

Verovatnoće preživljavanja po klasama:
- Prva klasa: 0.58
- Druga klasa: 0.42
- Treća klasa: 0.26

Zaključujemo da što je osoba "siromašnija" manje su joj šanse za preživljavanje. Takođe, jasno se vidi razlika u verovatnoćama preživljavanja između klasa (pogotovo između prve i poslednje), tako da ima smisla pretpostaviti da je klasa putnika uticala na šansu za preživljavanje.

Hipoteze koje testiramo:
- *H0* - Klasa putnika nije uticala na njegovu šansu da preživi
- *H1* - Klasa putnika je uticala na njeogvu šansu da preživi

Prilikom pokretanja funkcije `test_survived_dependant_on_pclass()` vidimo da je vrednost *test statistike* 91.72, a vrednost konstante iz kritične sekcije je 9.21, tako da zaključujemo: **Klasa putnika je imala veliki uticaj na njegovu šansu za preživljavanje.**

### Uticaj položaja kabine na šansu za preživljavanje.
Prisetimo se da polje *Cabin* u našoj tabeli ima najviše nedostajućih vrednosti. 
Prilikom analize prisutnih vrednosti, vidimo da se vrednosti kabine sastoji od slova, praćenog sa tri do četiri cifre.   
Značenje slova vidimo na narednoj slici:  

![cabin_letters](https://raw.githubusercontent.com/AizenAngel/titanic-dataset-statistical-analysis/master/img/cabin_letters.png)

Ovde vidimo da slova zapravo predstavljau oznaku palube. Prva klasa putnika je imala na raspolaganju palube [A-E], druga [D-F], a treća [E-G].

Prva klasa je bila najbliža vrhu broda, samim tim i čamcima za spasavanje. Zato je logično da su putnici ove klase imali najveće šanse za preživljavanjem što je i potvrđeno prethodnim testom.  

Prilikom testiranja smo izdvojili prvo slovo svake kabine (odnosno palubu na kojoj se kabina nalazi) i radili sa tim podatkom.

<table>
  <tr>
    <th></th>
    <th>A</th> 
    <th>B</th>
    <th>C</th>  
    <th>D</th> 
    <th>E</th>
    <th>F</th>
    <th>G</th> 
    <th>T</th>  
  </tr>
  <tr>
    <th>0</th>
    <td>12</td> 
    <td>21</td>
    <td>40</td>  
    <td>16</td> 
    <td>13</td>
    <td>10</td>
    <td>2</td> 
    <td>1</td>  
  </tr>
  <tr>
    <th>1</th>
    <td>10</td> 
    <td>44</td>
    <td>54</td>  
    <td>30</td> 
    <td>28</td>
    <td>11</td>
    <td>3</td> 
    <td>0</td>  
  </tr>
</table>

Zbog manjka podataka, ovde ne možemo zaključiti neko opšte pravio, međutim mi ćemo ipak da probamo da testiramo sledeće:
- *H0*: Kabine putnika i njihove šanse za preživljavanjem su nezavisne veličine
- *H1* - Putnici koji su bili smešteni u kabinama bliže vrhu broda su imali veće šanse za preživljavanjem.

Pokretanjem funkcije `test_survived_dependant_on_cabin()` dobijamo da je vrednost *test statistike* 7.44, a vrednost *konstante kritične sekcije* je 18.47. Dakle, **ove 2 veličine su nezavisne.**

### Uticaj broja rođaka / supružnika na preživljavanje

Želeli smo da proverimo da li broj rođaka / supružnika nekako utiče na preživljavanje. Procenat preživljavanja je prikazan na sledećem grafiku:

![plot_sibsp_vs_survived](https://i.postimg.cc/RF9fLT80/plot-sibsp-vs-survived.png)

Vidimo da su najbolju šansu za preživljavanje imali oni koji su imali najviše 3 člana porodice na brodu.

### Logistička regresija nad Survived

**Funkcija `predict()` name je iz nepoznatih razloga vraćala NA vrednost, pa zato nismo mogli da napravimo matricu konfuzije za prva 2 modela**

Prva stvar koju smo probali bila je da vidimo da li godine imaju uticaja na preživljavanje. Koristili smo posebne setove za trening i test i dobili smo sledeće rezultate:

### Survived ~ Age

#### Model

```
glm(formula = Survived ~ Age, family = "binomial", data = trainData)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-1.1167  -1.0227  -0.9557   1.3325   1.5421  

Coefficients:
             Estimate Std. Error z value Pr(>|z|)  
(Intercept) -0.141398   0.164767  -0.858   0.3908  
Age         -0.009006   0.005001  -1.801   0.0718 .
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 1072.1  on 796  degrees of freedom
Residual deviance: 1068.9  on 795  degrees of freedom
  (203 observations deleted due to missingness)
AIC: 1072.9

Number of Fisher Scoring iterations: 4
```
Odavde vidimo da Age ima uticaja. Klasifikacija nad test skupovima je dala sledeće rezultate:

``` 
Didn't survive     Survived
    244                0
```

### Survived ~ Age*Pclass

#### Model

```
glm(formula = Survived ~ Age * Pclass, family = "binomial", data = trainData)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-1.9713  -0.8815  -0.6714   1.0642   2.2660  

Coefficients:
             Estimate Std. Error z value Pr(>|z|)    
(Intercept)  2.857209   0.582057   4.909 9.16e-07 ***
Age         -0.030900   0.014754  -2.094   0.0362 *  
Pclass      -1.002942   0.234650  -4.274 1.92e-05 ***
Age:Pclass  -0.002059   0.006834  -0.301   0.7632    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 1083.59  on 801  degrees of freedom
Residual deviance:  964.02  on 798  degrees of freedom
  (198 observations deleted due to missingness)
AIC: 972.02

Number of Fisher Scoring iterations: 4

```
Odavde vidimo da `Pclass` ima mnogo više uticaja nego `Age` (što ima smisla). Klasifikacija nad test skupovima je dala sledeće rezultate:

``` 
Didn't survive     Survived
    152                92
```

### Survived ~ Pclass

#### Model

```
glm(formula = Survived ~ Pclass, family = "binomial", data = trainData)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-1.3917  -0.7751  -0.7751   0.9773   1.6427  

Coefficients:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept)  1.26067    0.19213   6.562 5.33e-11 ***
Pclass      -0.76984    0.08071  -9.538  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 1331.0  on 999  degrees of freedom
Residual deviance: 1234.8  on 998  degrees of freedom
AIC: 1238.8

Number of Fisher Scoring iterations: 4

```
Odavde vidimo da `Pclass` ima veoma velik uticaj na preživljavanje (što opet ima smisla). Klasifikacija nad test skupovima je dala sledeće rezultate:

``` 
Didn't survive     Survived
    233                76
```

Matrica konfuzije:
```
                predicted
testSurvived     Didn't survive Survived
  Didn't survive            157       41
  Survived                   76       35
```
**Odziv: 0.67**   
**Preciznost: 0.79**


## Biblioteke neophodne za rad:
- [imputeTS](https://github.com/SteffenMoritz/imputeTS)
- [ggplot2](https://ggplot2.tidyverse.org/)
- [kableExtra](https://www.rdocumentation.org/packages/kableExtra/versions/1.1.0)
- [mice](https://www.rdocumentation.org/packages/mice/versions/3.9.0/topics/mice)
