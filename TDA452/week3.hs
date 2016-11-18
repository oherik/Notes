-- 0
-- A

drop :: Int -> [a] -> [a]
drop n a | n < 1 = a
drop n a | n > length a = error "drop: index too high"
drop _ [] = []
drop n (x:xs) = Main.drop (n-1) xs

splitAt :: Int -> [a] -> ([a],[a])
splitAt n a | n < 1 = ([],a)
splitAt n a | n > length a = (a,[])
splitAt n a = (take n a, Main.drop n a)

-- B
zip3 :: [a] -> [b] -> [c] -> [(a,b,c)]
zip3 [] _ _ = []
zip3 _ [] _ = []
zip3 _ _ [] = []
zip3 (a:as) (b:bs) (c:cs) = (a,b,c) : (Main.zip3 as bs cs)

zip3' :: [a] -> [b] -> [c] -> [(a,b,c)]
zip3' a b c = [(x,y,z) | (x,(y,z)) <- (Prelude.zip a (Prelude.zip b c))]
-- How would you define a function zip3 which zips together three lists? Try to write a recursive definition and also one which uses zip instead; what are the advantages and disadvantages of the two definitions?

-- 1
isPermutation :: Eq a => [a] -> [a] -> Bool
isPermutation xs ys = and [(numOccurrences x ys)  == numOccurrences x xs|
                      x <- xs, y <- ys, x==y]   &&  length xs == length ys

-- 2
--duplicates :: Eq a => [a] -> Bool
removeDuplicates :: Eq a => [a] -> [a]
removeDuplicates [] = []
removeDuplicates (x:xs) | elem x xs = removeDuplicates xs
                        | otherwise = removeDuplicates (x:xs)

removeDuplicates' :: Eq a => [a] -> [a]
removeDuplicates' [] = []
removeDuplicates' xs | elem (last xs) (init xs) = removeDuplicates (init xs)
                     | otherwise = (removeDuplicates (init xs))++[(last xs)]

--3
pascal :: Int -> [Int]
pascal 0 = [1]
pascal n = 1:[(p !! i + p !! (i+1)) | i<- [0..(length p-2)]]++[1]
        where
          p = pascal (n-1)

--4
crossOut :: Int -> [Int] -> [Int]
crossOut x xs = [j | j <- xs, not (j `mod` x == 0)]

sieve :: [Int] -> [Int]
sieve [] = []
sieve (x:xs) = x:(sieve $ crossOut x xs)

--6
occursIn x xs = (not . null) [y | y <- xs, y == x]

allOccurIn xs ys = and [occursIn x ys | x <- xs]

sameElements xs ys = allOccurIn xs ys && allOccurIn ys xs

numOccurrences x xs = length [y | y <- xs, x == y]

bag :: Eq a => [a] -> [(a,Int)]
bag [] = []
bag xs = bag' xs []

bag' :: Eq a => [a] -> [(a,Int)] -> [(a,Int)]
bag' [] current = current
bag' (x:xs) current | not (occursIn x [ys | (ys,_) <- current]) =
                        bag' xs (current ++ [(x, numOccurrences x xs +1)])
bag' (x:xs) current | otherwise = bag' xs current

-- 8
pairs :: [a] -> [b] -> [(a,b)]
pairs xs ys = [(x,y) | x<-xs, y<-ys]

triad :: Int -> [(Int,Int,Int)]
triad n = [(a,b,c) | a<-[1..n], b<-[1..n], c<-[1..n],
          a*a + b*b == c*c, a<=b, b<=c]
