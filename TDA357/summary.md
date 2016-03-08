# Lecure notes
## Relational algebra
* Projection: **pi_i,j** R = {<ti,tj>|t € R}, samma som **SELECT**
* Selection: **sigma_c** R = [t | t € R AND C], samma som **WHERE**
* Theta join R **|><|_c** S = {<t,u>|t € R AND u € S AND C} = sigma_c{RxS}

## Functional dependecies
* Trivial: A -> A
* Splitting values: X -> B1, B2, B3, ... , Bn
* Closure: X⁺ = värden som kan nås från X, inkluderat X självt
* Signature: S = alla attribut
* Superkey: X så att X⁺ = S, dvs alla värden kan nås från X
* Key: minimal superkey.
* Candidate key: "primärnyckel"

Är inte X en supernyckel? Då gäller att X->A, non-key functional dependency. Innehåller delar som borde vara i en egen tabell. Detta är BCNF violation, om även A !€ X.

*title year -> star name* stämmer inte ens om det bara finns en stjärna listad per år i en tabell. Det ska **gälla för alla** teoretiska inputs.

## Multi-valued dependecies
X ->> Y
> Om ett land exporterar en produkt till ett annat land exporterar den även samma produkt till alla andra länder.  
> country ->> product

**4NF violation** om X inte är en supernyckel.

* *Relation* skrivs med stor bokstav.
* *attribut* skrivs med liten.

**LÄS PÅ OM NORMAL FORMS**

## SQL
CHAR(int) fylls på med whitespace. VARCHAR(int) har varierande längd.

UNION, INTERSECT, EXCEPT fungerar som U, upp-och-ner-U och /. Som i diskmatten.

Kan ha en nästlad where-query. Måste returnera <= 1 sak.

```SQL
SELECT name, 'big' AS size                              name | size
FROM countries                            ->             USA | big
WHERE population >= 100000000                           India| big
                                                         ... | ...
```
**UNION** får enbart användas mellan *queries eller query ochtable*. **Inte mellan tables**.

SET har unika saker. MULTISET har repetitioner.

**SELECT DISTINCT** i en query tar bort dubletter. Går från multiset till set. Dyr dock, kostar O(n²). Dubletter kan ha skapats vid projektion.

**ORDER BY** - sortera. Lägg *alltid sist* i queryn. Standard är ascending.
```SQL
ORDER BY population DESC:
eller
ORDER BY size ASC, name DESC
```

**GROUP BY**
Används vid *aggregate functions*
