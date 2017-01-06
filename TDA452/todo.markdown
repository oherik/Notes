Exhaustive Testing:  [slides](http://www.cse.chalmers.se/edu/year/2016/course/TDA452_Functional_Programming/lectures/OverloadingAndTypeClasses.html), p 21  
Bara bra vid tillräckligt små sets, men då bättre än random testning.

Test Data Distribution: [slides](http://www.cse.chalmers.se/edu/year/2016/course/TDA452_Functional_Programming/lectures/TestDataGenerators.html) p 21  
  collect r (validRank r) är rätt coolt, visar fördelning av testfallen. Eller collect (size h) (validHand h) för den delen.  
  > * Using collect to examine test data distribution.  
  > * Testing functions with preconditions (e.g. insert).


  Frequency, det man adderar upp till blir nämnaren. Ex en fördelning emd 1, 2, 3 blir den första 1/6, den andra 1/3 och den sista 1/2.


Efficiency of reverse: [slides](http://www.cse.chalmers.se/edu/year/2016/course/TDA452_Functional_Programming/lectures/AbstractDataTypes.html), p 2

Tail recursion

Invariant

Modules: [slides](http://www.cse.chalmers.se/edu/year/2016/course/TDA452_Functional_Programming/lectures/AbstractDataTypes.html), p 18  
smartQ och liknande är smart ja.  
Abstract types: representation is hidden, dvs man exporterar inte en typs konstruktorer i modulen. Typ.

Monads, translate do och >>= osv, [slides](http://www.cse.chalmers.se/edu/year/2016/course/TDA452_Functional_Programming/lectures/Monads.html) s 19 och framåt  
```haskell
do x <- m; more ; stuff  ⟹  m >>= (\x -> do more ; stuff)
```

> * Informative error messages from the monadic evaluator

^ Vad innebär det tro? Stod i sista sldies för kursen. Googla!

Left factorisation

IO är pure [på nåt magiskt sätt](http://chris-taylor.github.io/blog/2013/02/09/io-is-not-a-side-effect/). Monads håller purity.

Monadic Expression Evaluation

Laziness, infinite lists och hur man stoppar dem: [slides](http://www.cse.chalmers.se/edu/year/2016/course/TDA452_Functional_Programming/lectures/Laziness.html) s 14 och framåt

Lazy IO: [slides](http://www.cse.chalmers.se/edu/year/2016/course/TDA452_Functional_Programming/lectures/Laziness.html) s 28

=>

Setsen: [slides](http://www.cse.chalmers.se/edu/year/2016/course/TDA452_Functional_Programming/lectures/LooseEnds.html)

Case switches, tex med Maybe types:
```haskell
case ... of
  Nothing -> Nothing
  Just x -> case ... of
    Nothing -> Nothing
    Just y -> ...
```

let ... in  (Let the right one in håhåhå)

**!!** är index

Kvar att läsa igenom:  
Week 1 ~~A~~, ~~B~~   
Week 2 ~~A~~, ~~B~~   
Week 3 ~~A~~, ~~B~~   
Week 4 ~~A~~, ~~B~~  
Week 5 ~~A~~, ~~B~~   
Week 6 ~~A~~, ~~B~~  
Learn you a haskell  
Kanske kolla mer Sands
[Denna](http://adit.io/posts/2013-04-17-functors,_applicatives,_and_monads_in_pictures.html)
