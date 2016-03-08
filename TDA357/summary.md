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
Används vid *aggregate functions* (funktioner på hela tabellen). Ex:
```SQL
COUNT(*) FROM...
COUNT DISTINCT currency FROM...
SUM population
```

### Ordnung!
0. WITH
1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT **(men skrivs efter WITH)**
6. ORDER BY

WITH: *namn före*. AS: *namn efter*.
```SQL
WITH name AS (query)
```

## Joins
**L**  

a|b     
--|--
a1|b1
a2|b2

**R**

a|c     
--|--
a2|c2
a3|c3

### Cross join
Kartesisk produkt av alla rader.

L_a|b|R_a|c
--|--|--|--
a1|b1|a2|c2
a2|b2|a3|c3

### Natural join
Repeterar inte gemensamma attribut

a|b|c
-|-|-
a2|b2|c2

### Full outer join
Ska stämma överrens, kan ta tomma celler

a|b|c
-|-|-
a1|b1|
a2|b2|c2
a3| |c3

```
Rad:
1               } Outer left join  
2  Inner join   }                     }
3                                     } Outer right join
```

Jämföra med **NULL** Ger unknown! null = null ger false. Kan var bra för att ta bort rader med nullvärden.

## Mer bös
### Inline constraints
För attributes.
```SQL
code TEXT CHECK (code LIKE '___') PRIMARY KEY
```
**%**: Any number of characters
```SQL
sender TEXT REFERENCES Accounts(Number)
```
### Constraints
För tuples
```SQL
CONSTRAINT noSelfTrainsfer CHECK (sender <> recipient)
```
Klarar *inte* av nästlat eller aggregat (ex summa).

## Assertion
För tabeller, databaser. Checkas varje gång databasen uppdateras. Väldigt dyr och ineffektiv.
```SQL
CREATE ASSERTION name AS (condition)
```
## Trigger
För databaser
```SQL
CREATE TRIGGER namn
  BEFORE [eller] AFTER [nåt av följande]
    * INSERT 
    * UPDATE
    * DELETE
    ON table
    FOR EACH ROW eller STATEMENT
    EXECUTE PROCEDURE functionname;
```
En funktion ska alltså skapas. Kolla slidesen för exakt syntax.

## Funktion
**NEW** - tupeln som fås som argument vid ex INSERT. Kan vara **OLD** i DELETE-sammanhang.
```SQL
CREATE FUNCTION asdasdasd() RETURNS TRIGGER AS $$
BEGIN
  UPDATE ..........
END
$$ LANGUAGE 'plpgsql'   -- Procedural Language/PostgreSQL
```
**$$** - betyder ungeäfr open/close call. Kan ges ett namn där inne också, men strunta i det i nuläget.

På view:
```SQL
CREATE TRIGGER name
  INSTEAD OF [INSERT | UPDATE | DELETE] ON view    -- Välj något av dem.
```
