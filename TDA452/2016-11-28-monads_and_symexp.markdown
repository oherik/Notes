## Purity
Some functions are impure, in other languages. They use instance variables, for example.

## Monad
**Modification** of the return type

## The do-notation
Är egentligen en monad-grej



## Functor
Också en grej. Typ monad? fmap och annat

Alla instanser av monad-klasser är instanser av functor-klasser

```java
for(int i = 0; i < 9; i++ ){
  String line = "";
  if(i<4){
    line += "Nu ";
  }
  line += "kommer det ";
  if(i<3 || i == 8){
    line += "tomtar";
  }
  System.out.println(line);
}
```

## Applicative
skapar oftast en funktion mha *pure*.

```haskell
?> import Control.Applicative

?> [(+10),(+20)] <*> [1,2,3]
=>  [11,12,13,21,22,23]

?> pure (+10) <*> [1,2,3]
=> [11,12,13]

?> (+10) <*> [1,2,3]
=> error "Megaerror typ"

?> (+10) <$> [1,2,3]
=> [11,12,13]

?> return (+10) <$> [1,2,3]
=> error "Också megaerror typ"
```

**<$> är infix fmap**

Kan inte skriva
```haskell
funk a a = 10
```

Måste göra
```haskell
funk a b | a == b = 10
```
