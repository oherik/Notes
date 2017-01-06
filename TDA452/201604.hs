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
