-- 0
import Data.List
import Data.Maybe

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
