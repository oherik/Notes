import Data.List
import Test.QuickCheck
-- 1
-- i
xmas :: Int -> IO()
xmas n = do
            putStr (l n)
            return ()

l n =  unlines [replicate (n-i) ' ' ++ (concat (replicate i " *")) | i <- [1..n]]

-- ii
splitWhen :: (a -> Bool) -> [a] -> [[a]]
splitWhen expr list = case t of [] -> [h]
                                (x:xs) -> [h] ++ (splitWhen expr (tail t))
  where
    (h,t) = span (not . expr) list

-- iii
prop_splitWhen :: (a -> Bool) -> [a] -> Bool
prop_splitWhen p xs = (length (splitWhen p xs)) == 1 + length [i | i <- xs, (p i)]
 -- TODO kunde ha använt filter istället

 -- 2
  -- fa l m n = m ‘lookup‘ zip l n
  --fa :: (Eq a) => [a] -> a -> [b] -> Maybe b

  --fb [] a = a
  --fb (b:c) a = fb c (b a)
  --fb :: [(b -> b)] -> b -> b

  -- fc (a:b) (c:d) = b /= c
  -- fc _ e = null e
  --fc :: (Eq a) => [a] -> [[a]] -> Bool -- TODO lurig!

  --fd x = map (x:)
  --fd :: a  -> [[a]] -> [[a]]
  -- fd 'a' ["123","456"] = ["a123","a456] -- TODO kolla (:)

  -- 3
data Sudoku = Sudoku [[Int]]

ex = Sudoku [[3,6,0,0,7,1,2,0,0],[0,5,0,0,0,0,1,8,0],[0,0,9,2,0,4,7,0,0], [0,0,0,0,1,3,0,2,8],[4,0,0,5,0,2,0,0,9],[2,7,0,4,6,0,0,0,0],[0,0,5,3,0,8,9,0,0],[0,8,3,0,0,0,0,6,0],[0,0,7,6,9,0,0,4,3]]

-- i
showSudoku :: Sudoku -> String
showSudoku (Sudoku s) = unlines $ intersperse (replicate 17 '-') (format s)
format :: [[Int]] -> [String]
format (x:xs) = [concat (map (\i -> if i == 0 then " |" else show i ++ "|") x)] ++ format xs

-- ii
block :: (Int,Int) -> Sudoku -> [[Int]]
block (i,j) (Sudoku s) = transpose $ takeIndex i (transpose $ takeIndex j s)
  where
    takeIndex n s =  drop (n*3) (take ((n*3)+3) s)

-- 4
data Tree a = Leaf | Node a (Tree a) (Tree a)
  deriving Show

exTree = Node 2 (leafNode 1) (Node 1 (leafNode 1) (leafNode 0))
  where leafNode n = Node n Leaf Leaf

-- i
hBalanced :: Tree a -> (Int,Bool)
hBalanced Leaf = (0, True)
hBalanced (Node a t1 t2) = (1 + maximum [h1, h2], b1 && b2 && (abs (h1 - h2) <= 1))
  where
    (h1,b1) = hBalanced t1
    (h2,b2) = hBalanced t2

-- ii
allPaths :: Tree a -> [[a]]
allPaths Leaf = [[]]
allPaths (Node a t1 t2) = map (a:) (allPaths t1 ++ allPaths t2)

-- iii
balTree :: Gen (Tree Bool)
balTree = do
            height <- arbitrary
            t <- bTree (abs height)
            return t

bTree :: Int -> Gen (Tree Bool)
bTree 0 = return (Leaf)
bTree n = do
          val <- elements [True,False]
          t1 <- bTree (n-1)
          t2 <- bTree (n-1)
          t <- elements [Node val t1 Leaf, Node val Leaf t1,Node val t1 t2]
          return(t)
