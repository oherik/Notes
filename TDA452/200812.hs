import Data.List
import Test.QuickCheck
import Data.Char
-- 1
-- A
sameElems :: Eq a => [a] -> [a] -> Bool
sameElems [] [] = True
sameElems [] (a:as) = False
sameElems (x:xs) as = x `elem` as && sameElems xs (delete x as)

selections :: [a] -> [(a,[a])]
selections xs =     [(xs!!i,(removeIndex i xs)) | i<-[0.. length xs-1]]
  where
    removeIndex i xs = take i xs ++ drop (i+1) xs

-- C
prop_comb list = [ x | (x,_) <- (selections list)] == list

prop_back list = and $ map (sameElems list) [ (x:xs) | (x,xs) <- (selections list)]

-- 2
callCost c  | c <= 10 = 40
            | otherwise = 40 + 45 * (1 + (c - 11) `div` 30)

-- A
callCost' s = connectionFee + periodCost s
  where
    connectionFee = 40
    periodFee     = 45
    periodCost s  | s <= 10 = 0
                  | otherwise = periodFee + periodCost (s - 30)

prop_cost x = callCost x == callCost' x

-- B
letterTable :: [String] -> IO ()
letterTable xs = do putStrLn $ unlines $ compute xs
 where
   compute [] = []
   compute (x:xs) | all isAlpha x =  (x ++ ": " ++ show (length x)++ " letters"):(compute xs)
                  | otherwise = compute xs
-- C
-- Separera är bra för att minimera side effects. IO behövs för att printa, men
-- separation gör även att man kan använda funktioner utan att använda monads
-- hela tiden. Bra skit, yo.

-- 3
-- A
--data Expr
-- = Num Integer
-- | Add Expr Expr
-- | Mul Expr Expr

--eval :: Expr -> Integer
--eval (Num n) = n
--eval (Add e1 e2) = eval e1 + eval e2
--eval (Mul e1 e2) = eval e1 * eval e2

-- B
type VarName = String

data Expr
 = Num Integer
 | Var VarName
 | Add Expr Expr
 | Mul Expr Expr
 | Div Expr Expr

-- C
operMaybe :: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
operMaybe f (Just a) (Just b) = Just $ f a b
operMaybe _ _ _ = Nothing

-- D
eval :: [(VarName,Integer)] -> Expr -> Maybe Integer
eval _ (Num i) = Just i
eval vars (Var v) = lookup v vars
eval vars (Add e1 e2) = operMaybe (+) (eval vars e1) (eval vars e2)
eval vars (Mul e1 e2) = operMaybe (*) (eval vars e1) (eval vars e2)
eval vars (Div e1 e2) = safeDiv (eval vars e1) (eval vars e2)
  where
    safeDiv _ (Just 0) = Nothing
    safeDiv x y = operMaybe div x y

-- E
data BigExpr = Sum VarName Expr Expr Expr -- name, e, e', e''  (name, lower bound, upper bound, expression)

b1 = (Sum "x" (Num 0) (Num 3) (Var "x"))
b2 = (Sum "x" (Num 0) (Num 3) (Mul (Var "x") (Var "y")))

evalBig :: [(VarName,Integer)] -> BigExpr -> Maybe Integer
evalBig vars (Sum name lexpr uexpr expr) = case  eval vars lexpr of
                                            (Just l) -> case eval vars uexpr of
                                              (Just h) -> foldr (operMaybe (+)) (Just 0) [eval ((name,i):vars) expr | i <- [l..h]]
                                              _ -> Nothing
                                            _ -> Nothing

-- 4
type Name = String
type Born = Int
data Family = Fam Name Born [Family]

duck :: Family
duck = Fam "Uncle Scrooge" 1898
 [ Fam "Donald" 1932 []
 , Fam "Ronald" 1933
 [ Fam "Huey" 1968 []
 , Fam "Duey" 1968 []
 , Fam "Louie" 1968 []
 ]
 ]

-- A
y :: Family -> Born
y = maximum . z
 where z (Fam _ born kids) = born : concatMap z kids

-- B
-- Hittar när den yngsta familjemedlemmen är född

-- C
prop_Family :: Family -> Bool
prop_Family (Fam _ _ []) = True
prop_Family (Fam _ born kids) = all (> born) (map getBorn kids) &&
                                (and $ map prop_Family kids)
  where
    getBorn (Fam _ born _) = born

-- D
parent :: Name -> Family -> Maybe String
parent child (Fam name _ kids)  | elem child (getKidNames kids) = Just name
                                | otherwise = getJust $ map (parent child) kids
  where
    getKidNames [] = []
    getKidNames ((Fam name _ _):ks) = name:(getKidNames ks)
    getJust [] = Nothing
    getJust ((Just x):_) = Just x
    getJust (Nothing:js) = getJust js
