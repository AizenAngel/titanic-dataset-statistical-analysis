# Statisticka analiza skupa podataka Titanik

## Uvod

15.4.1912 globalno smatrani "nepotopopivi" brod Titanik je potonuo nakon sudara sa ledenim bregom. Na brodu nije bilo dovoljno camaca za spasavanje, tako da je zajedno sa sobom Titanik odneo oko 1500 zivota. <br>
Element srece je definitivno uticao na to ko od putnika ce preziveti a ko ne. <br>
Medjutim, mi smatramo da su postojali neki dodatni faktori koji su uticali na to ko od putnika ce biti stavljen na brod za spasavanje i ovim seminarskim radom zelimo da utvrdimo sta je to uticalo na odluku da li ce osoba preziveti ili ne. 

<br>

## Podela podataka
Titanik skup podataka je namenjen za vezbanje tehnika istrazivanja podataka, te se samim tim sastoji iz 2 dela:
<li><i>Trening deo</i></li>
<li><i>Test deo</i></li>
<br>
Posto nas trenutno nije interesovala ta podela, spojili smo trening i test podatke u jedan skup, koji ima 1309 kolona.

<br>

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

<br>

## Rad sa nedostajucim vrednostima: 
U prilogu je data tabela sa brojem nedostajucih vrednosti.
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

<br>

Vidimo da polja <i>Age</i>, <i>Fare</i>, <i>Cabin</i>, <i>Embarked</i> imaju 
nedostajuce vrednosti i u nastavku je dat opis, kako smo resavali taj problem za svaku od klasa pojedinacno

### Nedostajuce vrednosti za godine
Iz datog skupa, vidimo da <i>Age</i> atribut imaju 263 nedostajuce vrednosti. U zelji da sto bolje sacuvamo originalnost podataka, nismo ih aproksimirali, a kada se javila potreba za izucavanjem ovog atributa, uklonili smo nedostajuce vrednosti.

### Nedostajuce vrednosti za kabinu
Ovde je situacija gora nego za prehnodni slucaj, jer <i>Cabin</i> atribut ima 1014
nedostajucih vrednosti, tako da smo primenili istu strategiju.

### Nedostajuce vrednosti za cenu karte
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
    <li> Osoba je bila musko </li>
    <li> Pripadala je trecoj klasi </li>
    <li> Nije prezivela potonuce </li>
    <li> Ukrcala se iz Southampton-a </li>
</ul>

Zato smo odlucili da cenu karte ove osobe aproksimiramo srednjom vrednosti cene karata svih osoba muskog pola, trece klase, koje nisu prezivele potonuce i ukrcale su se iz luke Southampton.

### Nedostajuce vrednosti za luku ukrcavanja
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

Iz tabele zakljucujemo: 
<ul>
<li>U pitanju su bile osobe zenskog pola</li>
<li>Delile su kabinu</li>
<li>Obe su prezivele</li>
<li>Klasa putnika je bila ista (sto je logicno, jer su delile kabinu)</li>
</ul>



## Biblioteke:
- [imputeTS](https://github.com/SteffenMoritz/imputeTS)
