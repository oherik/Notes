import Test.QuickCheck

-- 1
-- i
range :: Ord a => [a] -> (a,a)
range (x:xs) = range' x x xs
  where
    range' mi ma [] = (mi,ma)
    range' mi ma (x:xs) | x < mi = range' x ma xs
                        | x > ma = range' mi x xs
                        | otherwise = range' mi ma xs

-- ii
splitOneOf :: Eq a => [a] -> [a] -> [[a]]
splitOneOf splitters list = case span (not . (`elem` splitters)) list of -- TODO kolla funktionslistan noggrannare. notElem finns!
                                (h,[])  -> [h]
                                (h,t)   -> [h] ++ splitOneOf splitters (tail t)

-- iii
prop_splitOneOf :: [Int] -> [Int] -> Bool
prop_splitOneOf splitters list = length (splitOneOf splitters list) == (length . filter (`elem` splitters)) list + 1

-- 2
-- i
fa :: (Eq a) =>  a -> [b] -> [a] -> Maybe b
fa m n l = m `lookup` zip l n

fb :: [(a -> b)] -> [[a] -> [b]]
fb [] = []
fb (b:c) = (map b) : fb c

fc :: (Eq a) => [a] -> [a] -> Bool
fc (a:b) (c:d) = a /= c && fc b d
fc _ _ = True

-- ii
fb' :: [(a -> b)] -> [[a] -> [b]]
fb' = map map

fc' :: (Eq a) => [a] -> [a] -> Bool
fc' as cs = and $ zipWith (/=) as cs

-- 3
type Sudoku = [[Int]]

ex = [[3,6,0,0,7,1,2,0,0],[0,5,0,0,0,0,1,8,0],[0,0,9,2,0,4,7,0,0],[0,0,0,0,1,3,0,2,8],[4,0,0,5,0,2,0,0,9],[2,7,0,4,6,0,0,0,0],[0,0,5,3,0,8,9,0,0],[0,8,3,0,0,0,0,6,0],[0,0,7,6,9,0,0,4,3]] :: Sudoku

-- i
allBlanks :: Sudoku -> [(Int,Int)]
allBlanks s = [(j,i) | i <- [0..8], j <- [0..8], (s!!i)!!j == 0]

-- ii
updateWith :: Int -> (Int,Int) -> Sudoku -> Sudoku
updateWith val (x,y) s = rBef ++ [cBef ++ [val] ++ cAft] ++ rAft
  where
    rBef = [s!!r | r <- [0..(y-1)]]
    rAft = [s!!r | r <- [(y+1)..8]]
    cBef = [(s!!y)!!c | c <- [0..(x-1)]]
    cAft = [(s!!y)!!c | c <- [(x+1)..8]]

arbPuzzle :: Sudoku -> Int -> Gen Sudoku
arbPuzzle s 0 = return s
arbPuzzle s n = do
                  (x,y)<-elements $ nonBlanks s
                  sud <- arbPuzzle (updateWith 0 (x,y) s) (n-1)
                  return sud
  where
    nonBlanks :: Sudoku -> [(Int,Int)]
    nonBlanks s = [(j,i) | i <- [0..8], j <- [0..8], (s!!i)!!j /= 0]

-- 4
-- i
