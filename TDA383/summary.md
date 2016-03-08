# Lecture notes
## Atomic
Kan inte vara icke-primitiv, kan inte avbrytas.
Atom -> odelbar. Atomiska oberationer är på samma sätt odelbara.

Har du något du vill ska vara atomic men inte är det? **Semaphores** is the way to go. De har ett antal **permits**.     
```
wait()
```

Väntar på en permit och tar den.  

```
signal()
```

Lägger tillbaka en permit *utan att kolla om det är tomt*.

För att se om det fungerar, skapa en **sekvens**. Samma svar när man kör med semaforer som om man skulle köra seriellt -> det fungerar som det ska.

## Limited critical reference
Har critical reference om en variabel:
* Skrivs till en variable som en annan tråd kan läsa från
* Läses till en variabel som en annan tråd kan skriva till

## Critical section
Se till att ha följande:
1. **Mutual exclusion**
2. No **deadlock**
3. No **starvation**

## Safety property
### Mutex
Hur man undviker: rita **states**.
**Fara** *Finite ends in bad state*. Då pajar saker.
Genom att skriva upp statesen kan man utesluta states som man tror kan finnas. Kan även göras som en **matris**. Matrisen består ofta av en kolumn med olika start-states, en kolumn med vad som händer om *p* går framåt och en om vad som händer om *q* går framåt (till exempel). Det går då att se om ett state kan nås eller inte.
## Liveness property
### Deadlock
Se till att det alltid finns en väg ur ett state.

 If you start in the preprocess, prove that you from state p2 and p3 always can reach p5. Also, from p5, prove that you can reach p2. Do the same for q's pre-process and critical section.

```
p1  Loopa för evigt               q1  Loopa för evigt
p2  Initialera  (pre-process)     q2  Gör nåt kul (pre-process)
p3  Gör nåt kul (pre-process)     q3  Initialera eller nåt (pre-process)
p4  Critical section              q4  Critical section
p5  Gör nåt kul                   q5  Gör nåt mer ickecritical
```

Bevisa att det inte går att nå deadlockstate: hitta det stadie i vilket deadlock uppstår. Backtracka och visa att det inte kan hända. Eller kolla i matrisen, om det ens går att komma dit, om du gjort en sådan.

### Starvation
När en tråd aldrig får komma till sin critical section. **Fara** *Infinite chain*.

## Busy waiting
Ligger och snurrar och väntar, gör inget av värde i loopen. Går den in i en critical section eller faktiskt gör någonting av intresse i loopen räknas det inte som busy waiting.

## Polling
Liknande busy wait. Kollar hela tiden vad en variabel är för att se om den går vidare. Kan anropa Thread.sleep(100) eller liknande i loopen, även om den sover så gör den inget vettigt.

## Dining philosophers problem
Bryt symmetrin! En idé är att få filosoferna att randomiza en tid då de efter den tiden lägger ner sitt bestick, men det är ineffektivt. Bättre: skapa en **indexering**. Då kan exempelvis den med lägst index alltid plocka gaffeln till höger medan de andra tar den till vänster. Eller så kan gafflarna få ett index, och den gaffeln med lägst index av de två vid en filosof plockas alltid upp först.

## Synchronized
Vid exception, sync lease

## Semaphores
Se till att köra s.release() vid exceptions, så inte allting fastnar.

## Producer - consumer buffer
Lägg semaforer runt det kritiska sektionerna.

## Monitor    
```
[Konst]
                                                                ooOOoOoooOOOoooooooOOOo
                                                            OOooooooOooOo
        USS Monitor                                       OoOoo
            aka                                          Oo
  USS Erik Prokrastinerar                               | |                   OOoooooooooooooo
                                                        | |            oooooooooooooOOoo
                                           ____________ | |         OOooo                |----
             |>          __                |  o o     | | |        oo                    |---´
             |__________/__\_______________|__________|/___\______|_|____________________|
~~~~~~~~~~~~~|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|==============~~~====~~===~~==~~=~~~~~~~~~~~~
```

```
signal(c)
```
Unblocks the first process that's blocked on c. Lämnar över mutexlås.

```
ReentrantLock
```
Låser monitorn.

**Fair** semaphore: de som väntar är i en kö och får tillträde därefter.

En monitor har följande:
 * State
 * Methods
 * Semaphore

## One-slot buffer
Kan lösas med **semaforer**. signal() - tråden som väntar unblockas.

### Blocking
```
release
```
Blockar aldrig.
```
lock()
```
Blockar, *men under väldigt kort tid* (förutsatt att den inte måste vänta på condition).
```
await()
```
Blockar.

### Signal and continue
1. signal() - fortsätter att köra till slutet, condition = true.
2. Den nya oblockade processen går in i critical-section-kön, längst bak. Dock kan någon av de som är före sätta **condition till false** innan den nya hinner in i critsec. Kan då riskera att skriva över buffern igen.

## Interrupt
Väcker om det försöker vänta. Sätter en **interrupted flag**. Blir koden interruptad? **Släpp allt**
```
finally {
  släpp_semaforer_och_andra_saker()
}
```
## Barrier
Väntar in den långsammaste. Signal ska alltid kunna ersättas av signalAll().

## Erlang
Oberoende och isolerade processer. Skalbart till max. Saker går sönder i runtime istället för vid kompilering: **dynamiskt**.

Använder shortcutting vid andalso: 
```
false andalso ([utvärderas ej])
```
