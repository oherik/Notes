import Data.List
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
