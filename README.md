# Statistička analiza skupa podataka Titanik

## Uvod

15.4.1912 globalno smatrani "nepotopopivi" brod Titanik je potonuo nakon sudara sa ledenim bregom. Na brodu nije bilo dovoljno čamaca za spasavanje, tako da je zajedno sa sobom Titanik odneo oko 1500 života.  

Element sreće je definitivno uticao na to ko od putnika će preživeti, a ko ne.  
Međutim, mi smatramo da su postojali neki dodatni faktori koji su uticali na to ko od putnika ce biti stavljen na brod za spasavanje i ovim seminarskim radom želimo da utvrdimo šta je to uticalo na odluku da li će osoba preživeti ili ne. 


## Podela podataka

Titanik skup podataka je namenjen za vezbanje tehnika istrazivanja podataka, te se samim tim sastoji iz 2 dela:
- *Trening deo*
- *Test deo*

Posto nas trenutno nije interesovala ta podela, spojili smo trening i test podatke u jedan skup, koji ima 1309 kolona.

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
    <td>Da li je osoba prezivela potonuce</td>
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
    <td>muski / zenski</td>
  </tr>
  <tr>
    <td>Age</td>
    <td>Godine</td>
    <td>0 - 81</td>
  </tr>
  <tr>
    <td>Sibsp</td>
    <td>Broj brace i sestara / supruznika na brodu</td>
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
    <td>Mesto odakle se osoba ukrcala na brod</td>
    <td>C - Cherbourg, Q - Queenstown, S - Southampton</td>
  </tr>
  <tr>
    <td>Name</td>
    <td>Ime i prezime osobe</td>
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

Iz datog skupa, vidimo da *Age* atribut ima 263 nedostajuće vrednosti. U želji da što bolje sačuvamo originalnost podataka, nismo ih aproksimirali, a kada se javila potreba za izučavanjem ovog atributa, uklonili smo nedostajuće vrednosti.

### Nedostajuće vrednosti za kabinu

Ovde je situacija gora nego za prehnodni slucaj, jer *Cabin* atribut ima 1014
nedostajućih vrednosti, tako da smo primenili istu strategiju.

### Nedostajuće vrednosti za cenu karte

Iz tabele, zakljucujemo da samo jednoj osobi fali infromacija o ceni karte. Ta osoba je:

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
    <li> Nije prezivela potonuće </li>
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

Sa slike možemo videti da ne postoji nikakva bitna razlika u ceni karte, tj. da su cene karata slično raspoređene u sva 3 mesta. Jedina interesantna stvar koju vidimo je da se najmanje ljudi ukrcalo u luci za oznakom Q (Queenstown).

### Uticaj pola na preživljavanje

Želeli smo da proverimo da li pol ima uticaja na preživljavanje. Početna pretpostavka je bila da će imati, jer se zna da su prednost u čamcima dobijali žene i deca. Sa sledećeg grafika vidimo da pretpostavka jeste tačna:

![plot_female_vs_male_survival_frequency](https://i.postimg.cc/0yMNMJVH/plot-female-vs-male-survival-frequency.png)

Još jedan grafik koji prikazuje preživele i umrle:

![plot_sex_vs_age_survived](https://i.postimg.cc/YqmcQfwg/plot-sex-vs-age-survived.png)

Odavde se može primetiti da je najveći procenat osoba muškog pola koji je preživeo zapravo bio u dečijem uzrastu, što se takođe uklapa sa činjenicom da su u čamcima sa spašavanje prednost imali žene i deca.

#### FALI TEST AKO POSTOJI 

### Uticaj putničke klase na preživljavanje

#### OVDE TEST

### Uticaj broja rođaka / supružnika na preživljavanje

Želeli smo da proverimo da li broj rođaka / supružnika nekako utiče na preživljavanje. Procenat preživljavanja je prikazan na sledećem grafiku:

![plot_sibsp_vs_survived](https://i.postimg.cc/RF9fLT80/plot-sibsp-vs-survived.png)

Vidimo da su najbolju šansu za preživljavanje imali oni koji su imali najviše 3 člana porodice na brodu. Naša pretpostavka zašto su podaci baš ovakvi je ta da su siromašnije porodice uglavnom bile veće i znamo da su one bile u trećoj klasi, a već smo pokazali putnička klasa itekako ima uticaja na preživljavanje


## Biblioteke:
- [imputeTS](https://github.com/SteffenMoritz/imputeTS)
