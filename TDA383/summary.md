# Lecture 1
## Atomic
Kan inte vara icke-primitiv, kan inte avbrytas.
Atom -> odelbar. Atomiska oberationer är på samma sätt odelbara.

Har du något du vill ska vara atomic men inte är det? **Semaphores** is the way to go. De har ett antal **permits**.     
```java
wait()
```

Väntar på en permit och tar den.  

```java
signal()
```

Lägger tillbaka en permit *utan att kolla om det är tomt*.

För att se om det fungerar, skapa en **sekvens**. Samma svar när man kör med semaforer som om man skulle köra seriellt -> det fungerar som det ska. 

##Limited critical reference
Har critical reference om en variabel:
* Skrivs till en variable som en annan tråd kan läsa från
* Läses till en variabel som en annan tråd kan skriva till

##Critical section
Se till att ha följande:
1. **Mutual exclusion**
2. No **deadlock**
3. No **starvation**

##Safety property - **mutex**
Hur man undviker: rita **states**.
**Fara** *Finite ends in bad state*. Då pajar saker. 
Genom att skriva upp statesen kan man utesluta states som man tror kan finnas. Kan även göras som en **matris**.

##Liveness proeprty - **deadlock**