import Data.List
import Data.Maybe
import Test.QuickCheck
-- 0
-- A
readNum n = do
              putStrLn $ "Yo inputta " ++ show n ++ " nummer rå, enter mellan varje"
              summerino <- readNum' n 0
              putStrLn $ "du kan vara "  ++ show summerino
              return ()

  where
    readNum' 0 s = return s
    readNum' n s = do
                      m <- getLine
                      summa <- readNum' (n-1) (s+(read m))
                      return summa


-- B
readSort :: IO ()
readSort = readSort' []
  where
    readSort' :: [Int] -> IO ()
    readSort' xs = do
                      n <- getLine
                      case (read n) of
                        0 -> putStrLn $ show $ sort $ 0:xs
                        x -> readSort' $ x:xs
                      return ()

-- C
repeat' :: IO Bool -> IO () -> IO ()
repeat' test grej = do
                      hur <- test
                      if hur then do
                        return ()
                        else do
                              _<-grej
                              _<-repeat' test grej
                              return ()

-- 1
look :: Eq a => a -> [(a,b)] -> Maybe b
look x []           = Nothing
look x ((x',y):xys)
  | x == x'         = Just y
  | otherwise       = look x xys

prop_LookNothing :: Eq a => a -> [(a,b)] -> IO ()
prop_LookNothing a as = case look a as of
                          Nothing     -> do
                                            putStrLn "Nothing found"
                          x           -> return ()

prop_LookJust :: (Eq a, Show b, Show a) => a -> [(a,b)] -> IO ()
prop_LookJust a as = case look a as of
                          (Just x)     -> do
                                            putStrLn $ "(" ++ show a ++ "," ++ show x ++ ") found"
                          x            -> return ()

prop_Look a as = case look a as of
                           (Just x)     -> do
                                             putStrLn $ "(" ++ show a ++ "," ++ show x ++ ") found"
                           x            -> do
                                             putStrLn "Nothing found"

-- 2
sequence' :: Monad m => [m a] -> m [a]
sequence' [] = return []
sequence' (a:as) = do
                      aRes <- a
                      rest <- sequence' as
                      return (aRes:rest)

mapM'     :: Monad m => (a->m b) -> [a] -> m [b]
mapM' _ [] = return []
mapM' func (a:as) = do
                      res <- func a
                      rest <- mapM' func as
                      return (res:rest)

onlyIf   :: Monad m => Bool -> m () -> m ()
onlyIf b m = do
                if b then m
                  else return ()

-- 3
game :: IO ()
game = do
          putStrLn "Tänk på ett nummer mellan 0 och 100"
          game' 0 100
  where
    game' l h = do
                  case l == h of
                    True  -> putStrLn $ "Det är " ++ show h ++ "! :D"
                    _     -> do
                      let mid = (l+h) `div` 2
                      putStrLn $ "Är det " ++ show mid ++ "?"
                      ans <- getLine
                      case ans of
                        "higher"  -> game' mid h
                        "lower"   -> game' l mid
                        "yes"     -> putStrLn "Yayyy :D"
                        _         ->  do
                          putStrLn "Skriv så man begriper"
                          game' l h

-- 5
-- A
listOf' :: Integer -> Gen a -> Gen [a]
listOf'  0 _ = return []
listOf'  n g = do
                  f <- g
                  fs <- listOf' (n-1) g
                  return (f:fs)

-- B
pairs :: Gen a -> Gen ([a],[a])
pairs g = do
            le  <- arbitrary
            l1  <- listOf' (abs le) g
            l2  <- listOf' (abs le) g
            return (l1,l2)

-- C
prop_zip_inv :: Gen Bool
prop_zip_inv = do
                  l <- arbitrary
                  l1 <- listOf' (abs l) (arbitrary :: Gen (Int,Int))
                  let (l21,l22) = unzip l1
                  let l2 = zip l21 l22
                  return (l1 == l2)

prop_unzip_inv :: Gen Bool
prop_unzip_inv = do
                    (l11,l12) <- pairs (arbitrary :: Gen Int)
                    let l2 = unzip $ zip l11 l12
                    return $ (l11,l12) == l2

-- 6
-- A
ordered :: Ord a => [a] -> Bool
ordered xs = case xs of
              [] -> True
              (x:[]) -> True
              (x:xs) -> x <= head xs && ordered xs

-- B
randPos :: Gen Integer
randPos = do
            v <- arbitrary
            return $ abs v

randOrd :: Gen [Integer]
randOrd = do
            l <- randPos
            li <- listOf' l randPos
            case li of
              [] -> return []
              _  -> do
                      f <- elements li
                      return $ randOrd' f li
  where
    randOrd' s [] = []
    randOrd' s (x:xs) = (s+x):randOrd' (s+x) xs

prop_randOrd :: Gen Bool
prop_randOrd = do
                  l <- randOrd
                  return $ ordered l
