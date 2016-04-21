# TV-problem
* Lösningen är inte samma != vår lösning är fel
* Skriv alla antaganden
* Var bättre på att välja worst case scenarios. Fördubbla/halvera alla skattade konstanter, till exempel.
* Tänk på målet! Måste företaget få ens tor vinst för att överleva, eller nöjd med långsammare och säkrare vinst?
* Tänk på vad du skulle säga till kunden. Modell -> verklighet -> modell -> verklighet osv. Loopen. Glöm inte den.

# Sjukhus
* Ett **namn är inte en variabel**. Den är bara satt till nåt som finns i verkligheten.
* **Specialfall först!**
* Linjärprogrammering är bra för att man då kan ta flera miljoner variabler utan större problem.
  * Därför algoritmer inte ska användas i den här kursen. Kan bli 2<sup>n</sup> i komplexitet osv. Använd *matematisk* modellering.

## Linjärprogrammering
* Har vi nytta av den "värdelösa" lösningen med 0.8-variabler och så vidare? 0.8 borde vara ett. 0.2 borde vara två. Det ger en indikation, även om man inte kan avrunda direkt.
  * Vi vet att den riktiga, diskreta lösningen *aldrig kan bli mindre* än den i den oriktiga kontinuerliga.
  * Kör NMinimize först.
    * Chansar på att ex s6 är = 1 och kör igen. Ny konstig lösning
    * Fixerar s2 till 1 och kör igen. Blev en heltalslösning, nice!
    * Testar de andra också, ex fixera s1 till 0 och så vidare. Ser att ingen blir mindre än lösningen där s2 var satt till 1.
* Har likheter och olikheter som består av raka linjer eller plan. Inga in- eller utbuktningar.
  * Kan skära bort de resultat som skulle kunna ge fel svar i den diskreta lösningen

# Nätverk
* Tänk som elknutsformeln i Modul 1. Rita pilar och använd X_<sub>AB</sub> = X_<sub>BD</sub> + X_<sub>BE</sub>, exempelvis.
* Kom ihåg att *verklig riktning != referensriktning* nödvändigtvis. Det kan bli minusflöde, och det är helt okej. Då blir ju det verkliga flöde åt andra hållet istället.
  * Alltså: **referensriktningar** är viktiga i modellering
* Skulle kunna använda samma metod för att optimera sovjetiska anfallsplaner för Europa eller dra pipelines för olja

# Bro
* Finns det en obalans kommer det efter tiden planas ut.
* *Braess paradox*
  * Specialfall av spelteorins *Nashjämvikt*
