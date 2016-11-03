# Modelling and datatypes


```haskell

deriving Show -- gör så att man kan printa det, printen blir då namnet på konstruktorn
-- Ex
show Spades
```

Finns även cases. 
```haskell
f suit = case colour suit of
	Red -> (...)
	Black -> (...)
```

You can **use function calls in guards**. Kan vara bra för Lab 2.

Om Card är en datatyp, ex Card = Card {rank :: Rank, suit : Suit}, kan ranken nås via rank c1, där c1 är av typen Card.

where-clause är smidigt för local definitions.
