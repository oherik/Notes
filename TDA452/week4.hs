-- 0
import Data.List
import Data.Maybe
import Test.QuickCheck
import System.Random

readNum :: IO ()
readNum = do
        putStrLn "How many numbers do you want to add together?"
        n <- readLn
        if n > 0
          then
            read' n 0
            else do putStrLn "Enter a positive int, please"
                    readNum

read' :: Int -> Int -> IO ()
read' 0 sum = putStrLn $ "Sum: " ++ show sum
read' n sum = do
          putStrLn "Enter a number: "
          val <- readLn
          if val < 0
            then do putStrLn "Only positive integers allowed"
                    read' n sum
          else do read' (n-1) (sum+val)

readUntilZero  :: IO ()
readUntilZero = do
              readUntilZero' []

readUntilZero' :: [Int] -> IO ()
readUntilZero' xs = do
                    val <- readLn
                    if (val == 0) then do
                      putStrLn $ show $ sort (val:xs)
                      else do
                      readUntilZero' (val:xs)

repeat' :: IO Bool -> IO () -> IO ()
repeat' test op = do
                  test' <- test
                  if test' then do
                  op
                  repeat' test op
                  else do
                    putStrLn "Klart!"

repeatTest :: IO ()
repeatTest = repeat' readLn (putStrLn "Enter True or False")

-- 1

look :: Eq a => a -> [(a,b)] -> Maybe b
look x []           = Nothing
look x ((x',y):xys)
  | x == x'         = Just y
  | otherwise       = look x xys

prop_LookNothing :: Eq a => a -> [(a,b)] -> Bool
prop_LookNothing x xs = isNothing $ look x xs

prop_LookJust :: Eq a => a -> [(a,b)] -> Bool
prop_LookJust x xs = isJust $ look x xs

prop_Look :: Eq a => a -> [(a,b)] -> Bool
prop_Look x xs = (prop_LookJust x xs && (not (prop_LookNothing x xs))) ||
            ((not (prop_LookJust x xs)) && prop_LookNothing x xs)

-- 2
sequence' :: Monad m => [m a] -> m [a]
sequence' [] = return []
sequence' (x:xs) = do v <- x
                      vs <- sequence' xs
                      return $ v:vs


-- TODO VAAAAAaaaaaararrrfföööööööööör??????????

-- 3

game :: IO ()
game = do
        putStrLn "Think of a number between 1 and 100!"
        game' 0 101

game' :: Int -> Int -> IO ()
game' lo hi = do
      putStrLn $ "Is it " ++ show mid ++ "?"
      ans <- getLine
      if(ans == "higher") then
        game' mid hi
        else if(ans == "lower") then
          game' lo mid
          else if(ans == "yes") then do
            putStrLn "Great, I won!"
            else do
              putStrLn "Valid input: yes, higher, lower"
              game' lo hi
            where
              mid = (div (lo+hi) 2)

-- 5
listOf :: Integer -> Gen a -> Gen [a]
listOf n g  | n < 0 = error "Men sluta"
            | n == 0 = return []
            | otherwise = do v <- g
                             vs <- (Main.listOf (n-1) g)
                             return (v:vs)

listOf' :: Gen Integer -> Gen a -> Gen ([a],  [a])
listOf' i g = do l <- i
                 let v = valid l
                 l1 <- (Main.listOf v g)
                 l2 <- (Main.listOf v g)
                 return (l1,l2)

valid 0 = 1
valid v = abs v

--r_listOf' :: Gen ([Integer],  [Integer])
r_listOf'= listOf' validInteger (elements [1..200])


prop_1 :: (Eq a) => (Eq b) => [a] -> [b] -> Bool
prop_1 l1 l2 = (x == l1) && (y == l2)
  where
    (x,y) = unzip (zip l1 l2)

prop_2 :: (Eq a) => (Eq b) => [(a,b)] -> Bool
prop_2 l1 = l1 == l2
  where
    (x,y) = unzip l1
    l2 = zip x y

prop_1' (x,y) = prop_1 x y


prop_3 = forAll r_listOf' prop_1'
--  where (x,y) = r_listOf'


-- TODO how use listOf'?
validInteger :: Gen Integer
validInteger = do n <- arbitrary
                  return $ abs n + 1

-- 6

ordered :: (Ord a) => [a] -> Bool
ordered l | length l < 2 = True
          | otherwise  = and [l !! i <= l !! (i+1) | i <- [0.. (length l -2 )]]
