# Statisticka analiza skupa podataka Titanik

## Uvod

15.4.1912 globalno smatrani "nepotopopivi" brod Titanik je potonuo nakon sudara sa ledenim bregom. Na brodu nije bilo dovoljno camaca za spasavanje, tako da je zajedno sa sobom Titanik odneo oko 1500 zivota. <br>
Element srece je definitivno uticao na to ko od putnika ce preziveti a ko ne. <br>
Medjutim, mi smatramo da su postojali neki dodatni faktori koji su uticali na to ko od putnika ce biti stavljen na brod za spasavanje i ovim seminarskim radom zelimo da utvrdimo sta je to uticalo na odluku da li ce osoba preziveti ili ne. 

## Podela podataka
Titanik skup podataka je namenjen za vezbanje tehnika istrazivanja podataka, te se samim tim sastoji iz 2 dela:
<li><i>Trening deo</i></li>
<li><i>Test deo</i></li>
<br>
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
    <td>0/1</td>
  </tr>
  <tr>
    <td>Pclass</td>
    <td>Klasa putnika</td>
    <td>1- prva, 2 - drugam, 3 - treca</td>
  </tr>
  <tr>
    <td>Sex</td>
    <td>Pol</td>
    <td>muski, zenski</td>
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
    <td>C = Cherbourg; Q = Queenstown; S = Southampton</td>
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


## Biblioteke:
- [imputeTS](https://github.com/SteffenMoritz/imputeTS)
