-- 1 --
sales :: Int -> Int
...

-- a
zeroWeeks :: Integer -> Integer

-- i
zeroWeeks n = length [x | x <- [0..n], (sales x) == 0]

-- ii
zeroWeeks n = length $ filter (\x -> (sales x) == 0) [0..n]  Duger nog :)

-- iii
zeroWeeks n = zeroWeeks' 0 n
  where
    zeroWeeks' s (-1) = s
    zeroWeeks' s n | (sales n) == 0 = zeroWeeks' (s+1) (n-1)
    zeroWeeks' s n | otherwise = zeroWeeks' s (n-1)

-- iv

zeroWeeks n = foldr zeroWeeks' 0 [0..n]
  where
    zeroWeeks' n t | (sales n) == 0 = 1 + t
    zeroWeeks' n t | otherwise = 0 + t

-- b
Hittar den veckan (eller de veckorna) på intervallet [0..n] där det sålts som mest.

maxWeeks n = [i | (i,v) <- zip [0..n] (saleWeeks n), (v == (maximum (saleWeeks n)))]
  where
    saleWeeks n = map sales [0..n]

-- 2 --
-- a
data Ticket = Train City City TrainClass | Bus City City | Flight City City FlightClass
data TrainClass = First | Second
data FlightClass = Business | SEconomy | Economy
type City = String

-- b
type Journey = [Ticket]
valid :: [Ticket] -> Bool
valid journey = valid' (map cityPair journey)
  where
    cityPair (Train c1 c2 _) = (c1,c2)
    cityPair (Bus c1 c2 _) = (c1,c2)
    cityPair (Flight c1 c2 _) = (c1,c2)

valid' cities | length cities < 2 = True
valid' ((_,end):cities)=  end == (startCity (head cities)) && valid' cities
  where
    (start,_) = head cities


startCity (start,_) = start

cityPairs journey = map cityPair journey

-- 3 --
data Logic = Const Bool | And Logic Logic | Not Logic | Var String
type Env = [(String,Bool)]
...
import Data.Maybe

eval :: Env -> Logic -> Maybe Bool
eval xs (And l1 l2) = if((eval xs l1 == Nothing)||(eval xs l2 == Nothing)) then
                        Nothing
                        else
                          Just (fromJust (eval xs l1) && fromJust (eval xs l2))
eval _ (Const c) = Just c
eval xs (Not l) = if(eval xs l == Nothing) then
                    Nothing
                    else
                      Just(not (fromJust eval xs l))
eval xs (Var s) | s == lookup s xs

TODO fixa bättra lazy evaluation! Jaaa! Som
case ... of
  Nothing -> Nothing
  Just x -> case ... of
    Nothing -> Nothing
    Just y -> ...

-- c
import Data.List
import Data.Maybe

taut :: Logic -> Bool
taut l = and [b | Just b <- map (flip eval l) (environments (variables l))]

eval' :: Env -> Logic -> Bool
eval' xs (Var v) = fromJust $ lookup v xs
eval' xs (And l1 l2) = eval' l1 && eval' l2
eval' xs (Const c) = c

environments :: [String] -> [Env]
environments [] =[[]]; environments (v:vs) = map (++[(v,True)]) (environments vs) ++ map (++[(v,False)]) (environments vs)

variables :: Logic -> [String];variables (Const _) = [];variables (And l1 l2) = variables l1 `union` variables l2;variables (Not l) = variables l;variables (Var v) = [v]

-- 4
perm' :: Eq a => [a] -> Gen [a]
perm' [] = return []
perm' xs = do
            rx <- elements xs
            ys <- perm' $ delete rx xs
            return (rx:ys)

perm :: [a] -> Gen [a]
perm xs =

perm' nums =

  -- 5

data Rose a = R a [Rose a]

-- a
example :: Rose Int
example = R 1 [R 2 [R 4 [], R 5 [], R 6 []], R 0 [], R 3 [R 7 []]]

-- b
roseMap :: (a -> b) -> Rose a -> Rose b
roseMap f (R x sR) = R (f x) (map (roseMap f) sR) // TODO map kan appliceras på tomma listor, returnerar då en tom lista

-- c
level :: Int -> Rose a -> [a]
level 1 (R x _) = [x]
level m (R x []) = []
level m (R x sR) = concat $ map (level (m-1)) sR

-- d
type DirName = String
type FileName = String
type Contents = String
data File = File FileName Contents

type Dir = Rose (DirName, [File])

-- 5
find:: String -> Dir -> [String]
