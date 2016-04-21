# 2
## a
other = !i.
 Dvs om i = 0 är other 1. Om i = 1 är other = 0.

```
private int turn = 0;
private boolean flag[] = {false, false};
process CS ((int i=0;i<2;i++)) {                  
  other = (i+1)%2;                                      
  while (true) {                                        
    flag[i] = true;                                       1
    turn = other;                                         2
    while (flag[other] && turn==i) ;                      3
    // Critical section                                   4 CS
    flag[i] = false;                                      5
  }
}






Process  0          Process 1                   Flaggor               turn
i = 0               i = 1                       [true][true]         0
other = 1           other = 0

                          i = 0, o = 1     i = 1, o = 0
State (p,q,[],[],turn)    p moves     q moves
1,1,f,f,0                2,1,t,f,0    1,2,f,t,0
2,1,t,f,0                3,1,t,f,1    2,2,t,t,0
1,2,f,t,0                2,2,t,t,0    1,3,f,t,0
c3,1,t,f,1                4,1,t,f,1    c3,2,t,f,0
2,2,t,t,0                3,2,t,t,1    2,3,t,t,0
1,3,f,t,0                2,3,f,t,1    1,4,f,t,0
c3,2,t,f,0                4,2,t,f,0    c3,3,t,f,0
3,2,t,t,1                4,2,t,t,1    [loop]
1,4,f,t,0                2,4,t,t,0    1,5,f,t,0
4,2,t,f,0                5,2,t,f,0    4,3,t,f,0
c3,3,t,f,0                c4,3,t,f,0    3,4,t,f,0
c4,3,t,f,0                5,3,t,f,0    c4,4,t,f,0     <- Mutex brister
```

Nej.  fast vänta kommer aldrig till 3,2,t,f,0 eller?

```
State (p,q,[],[],turn)    p moves     q moves
3,5,t,t,0                             3,1,t,f,0
3,4,t,t,0                             3,5,t,t,0
3,3,t,t,0                             3,4,t,t,0
3,2,t,t,1                             3,3,t,t,0


(3,2)(3,3)(3,4)(3,5)(3,1)(3,2)()

... Nytt försök, baklängestracking

4,4   3,4            3,4,t,t,1      2,4,t,t,0     2,3,t,t,0
      _,f,_                     
        1
      3,4,_,f,_       2,4,t,t,0     2,3,t,t,0     2,2,t,t,1
      3,4,_,_,1       

      3,4,t,f,0       3,3,_
      3,4,f,f,0
      3,4,t,t,1 *
      3,4,f,t,1
      3,4,f,f,1
      3,4,t,f,1




2,2,t,t,1   1,2,f,t,1  1,1,f,f,1     5,1,t,f,1    4,1,t,f,1     3,1,t,f,1

1,2,f,t,1   1,1,f,f,1  5,1,t,f,1     4,1,t,f,1    3,1,t,f,1     2,1,t,f,0


2,1,t,f,0

1,1,f,f,0

Alltså!

p q 0 1 t
1 1 f f 0  
2 1 t f 0
3 1 t f 1
4 1 t f 1
5 1 t f 1
1 1 f f 1
1 2 f t 1
2 2 t t 1
2 3 t t 0
2 4 t t 0
3 4 t t 1
4 4 t t 1  <- BOOM headshot

```

## b

```
private int turn = 0;
private boolean flag[] = {false, false};
process CS ((int i=0;i<2;i++)) {                  
  other = (i+1)%2;                                      
  while (true) {                                        
    flag[i] = true;                                       1
    turn = i;                                             2
    while (flag[other] && turn==other) ;                  3
    // Critical section                                   4 CS
    flag[i] = false;                                      5
  }
}
Process  0          Process 1                   Flaggor               turn
i = 0               i = 1                       [true][true]         0
other = 1           other = 0

                          i = 0, o = 1     i = 1, o = 0
State (p,q,[],[],turn)    p moves     q moves
1,1,f,f,0               2,1,t,f,0   1,2,f,t,0  c
2,1,t,f,0               3,1,t,f,0   2,2,t,t,0
1,2,f,t,0               2,2,t,t,0   1,3,f,t,1
2,2,t,t,0               3,2,t,t,0   2,3,t,t,1
3,2,t,t,0               4,2,t,t,0   3,3,t,t,1
4,2,t,t,0                    dc     4,3,t,t,0
3,3,t,t,1               loop        3,4,t,t,1

```

## c

```
private int turn = 0;
private boolean flag[] = {false, false};
process CS ((int i=0;i<2;i++)) {                  
  other = (i+1)%2;                                      
  while (true) {                                        
    flag[i] = true;                                       1
    turn = i;                                             2
    while (flag[other] && turn==i) ;                      3
    // Critical section                                   4 CS
    flag[i] = false;                                      5
  }
}
Process  0          Process 1                   Flaggor               turn
i = 0               i = 1                       [true][true]         0
other = 1           other = 0

                          i = 0, o = 1     i = 1, o = 0
State (p,q,[],[],turn)    p moves     q moves
1,1,f,f,0               2,1,t,f,0   1,2,f,t,0  c
2,1,t,f,0               3,1,t,f,0   2,2,t,t,0
1,2,f,t,0               2,2,t,t,0   1,3,f,t,1
2,2,t,t,0               3,2,t,t,0   2,3,t,t,1
3,2,t,t,0               loop        3,3,t,t,1
3,3,t,t,1               4,3,t,t,1   loop
4,3,t,t,1               5,3,t,t,1   loop
5,3,t,t,1               1,3,f,t,1   loop
1,3,f,t,1               2,3,t,t,1   1,4,f,t,1
2,3,t,t,1               3,3,t,t,0   loop
3,3,t,t,0               loop        3,4,t,t,0
3,4,t,t,0               loop        3,5,t,t,0
1,4,f,t,1               2,4,t,t,1   1,5,f,t,1
2,4,t,t,1               3,4,t,t,0   2,5,t,t,1
2,5,t,t,1               3,5,t,t,0   2,1,t,f,1
3,5,t,t,0               loop        3,1,t,f,0
3,1,t,f,0               4,1,t,f,0   3,2,t,t,0
4,1,t,f,0               5,1,t,f,0   4,2,t,t,0
4,2,t,t,0               5,2,t,t,0   4,3,t,t,1
4,3,t,t,1               5,3,t,t,1   loop
5,3,t,t,1               1,3,f,t,1   5,4,t,t,1
5,4,t,t,1               1,4,f,t,1   5,5,t,t,1
5,5,t,t,1               1,5,f,t,1   5,1,t,f,1
1,5,f,t,1               2,5,t,t,1   1,1,f,f,1
1,1,f,f,1               2,1,t,f,1   1,2,f,t,1
2,1,t,f,1               3,1,t,f,0   2,2,t,t,1
3,1,t,f,0               4,1,t,f,0   3,2,t,t,0
1,2,f,t,1               2,2,t,t,1   1,3,f,t,1
2,2,t,t,1               3,2,t,t,0   2,3,t,t,1
3,4,t,t,0               loop        3,5,t,t,0

```

# 3
```java
class PlayList {
  private List<Song> playlist = new List<Song>();
  public void addSong (Song title) ;
  public Song CurrentSong() ;
  public Song nextSong() ;
}
```

```java
class PlayListThreadSafe {
  // some other fields...
  private final Lock lock = new ReentrantLock();
  Condition playlistFree = lock.newCondition();
  boolean busy = false;
  PlayList pl;

  public PlayListThreadSafe(){
    pl = new PlayList();
  }

  public void addSong (Song title) {
      lock.lock();
      try{
        while(busy) playlistFree.await();
        busy = true;
        pl.addSong(title);
        busy = false;       
      } catch (InterruptedException e){
        //Do something
      } finally {
        playlistFree.signal();        
        lock.unlock();
      }
    }
  }
  public Song CurrentSong(){
    lock.lock();
    try{
      while(busy) playlistFree.await();
      return pl.CurrentSong;
    }catch(InterruptedException e) {
      //Do something
    } finally{
      playlistFree.signal();
      lock.unlock();
    }

  }
  public Song nextSong(){
    lock.lock();
    try{
      while(busy) playlistFree.await();
      return pl.nextSong;
    } catch(InterruptedException e){
      //Do something
    } finally{
      playlistFree.signal();
      lock.unlock();
    }
  }
}
```
## b
```java
class PlayListThreadSafe {
  List requests = new ArrayList();
// The same methods and private variable as in the point a)
  public void DJmodeON(){
    lock.lock();
    try{
      busy = true;
    } catch(InterruptedException e){
      //Do something
    } finally{
      lock.unlock();
    }

  }

  public void DJmodeOFF(){
    try{
      busy = false;
    } catch(InterruptedException e){
      //Do something
    } finally{
      playlistFree.signal();
      lock.unlock();
    }
  }
}
```
# 4
## a

```java
-------------_______----------------
                    |
-------------       ---------------
            |
____________--------_______________

En semafor behövs för mitten i alla fall


public class Bridge{
  private static Semaphore center;
  public Bridge(int noOfCars){
    center = new Semaphore();
    for(int i = 0; i < noOfCars; i++)
      new Car.start();
  }


  private class Car extends Thread{
    public void run(){
      try{
        center.acquire();
        driveForward();
        center.release();  
      } catch (InterruptedException e){
        System.out.println("Gick ju åt helvete detta ja");
      }    
    }
    private void driveForward(){
      this.sleep(2000);
    }

  }

}

```
## b
```java

public class Bridge{
  private static Semaphore center;
  public Bridge(int noOfCars){
    center = new Semaphore(1);
    List cars = new ArrayList(Car);
    for(int i = 0; i < noOfCars; i++){}
      cars.add(new Car(1));
      cars.add(new Car(0));
    }
    Operator op = new  Operator(noOfCars/8,cars);
    op.start();
  }
  private class Car extends Thread{
    int goingEast;
    boolean done;
    private Car(int goingEast){
      this.goingEast = goingEast;
      done=false;
    }
    public boolean isDone(){
      return done;
    }
    public void run()
      try{
        center.acquire();
        driveForward();
        center.release();  
      } catch (InterruptedException e){
        System.out.println("Gick ju åt helvete detta ja");
      }    
    }
    private void driveForward(){
      this.sleep(2000);
    }  
  }

  private class Operator extends Thread(){
    int numberOfCars;
    List cars;
    private Operator(numberOfCars, cars){
      this.numberOfCars = numberOfCars;
      this.cars = cars;
    }

    public void run(){
      try{



      } catch(InterruptedException) e{
        //Do something
      }


    }


  }


}
ffufufufufufuffffcvckckkkckkckccudfukckc   okej så varje bil har sin egna semafor.

```
# 5
```
module(sem)
-export([createSem/1, acquire/1, release/1]).


createSem(InitialValue) ->
  Monitor = spawn(fun -> loop() end),
  initialize(Monitor, InitialValue),
  Monitor.

initialize(Monitor, 0) ->
    ok;
initialize(Monitor, FreeLeft) ->
  release(Monitor),
  initialize(Monitor, FreeLeft).

loop(H) ->
  receive
    {acquire, Ref, Sender} ->
      receive
        {signal, Ref2} ->
          self()!{ok, Ref2}
      end,
      Sender ! {acquire_response, Ref};      

    {release, Ref, Sender} ->
      Ref2 = make_ref,
      self()!{signal, Ref2},
      receive {ok, Ref2} -> ok end,
      Sender ! {release_response, Ref}
  end.


acquire(Semaphore) ->
  Ref = make_ref(),
  Semaphore ! {acquire, Ref, self()},
  receive
    {acquire_response, Ref} -> semaphore_acquired
  end.


release(Semaphore) ->
  Ref = make_ref(),
  Semaphore ! {release, Ref, self()},
  receive
    {release_response, Ref} -> semaphore_released
  end.





Erlang’s processes can, for instance, use this module in the following manner:
Mutex = createSem(0),
acquire(Mutex),
%% critical section
release(Mutex),
%% rest of the program
```
# 6

## a

Assume that you have the function sum_of_products(Xs, Ys) which takes lists Xs and Ys
of equal length, and produces the sum of the point-wise multiplication of the list. In other
words, it produces the number X_1*Y_1 + X_2*Y_2 + ... + X_n*Y_n, where X_i is the ielement
of Xs, and Y_i is the i-element of Ys.
Implement the function mult_parallel(Vector,Matrix) which produces the result of multiplying
a Vector of n elements with a quadratic matrix of size n×n using sum_of_product
and exploiting concurrency as much as possible.

```
mult_parallel(Vector,Matrix) ->
  Transposed = transpose(Matrix),
  pmap(fun(Row) -> sum_of_products(Vector,Row) end, Transposed).

```

## b 
