import Test.QuickCheck
---- 0 ----
-- a) eval (Lit 67) = 67
-- b) eval (Add (Sub (Lit 3) (Lit 1)) (Lit 3)) = eval (Sub (Lit 3) (Lit 1))
-- + eval (Lit 3) = eval Lit 3 - eval Lit 1 + eval Lit 3 = 3 - eval Lit 1 + eval Lit 3 = 3 - 1 + eval Lit 3 = 2 + eval Lit 3 = 2 + 3 = 5
-- c) Palla jag fattar

data Expr
  = Num Integer
  | Add Expr Expr
  | Sub Expr Expr
  | Mul Expr Expr
  | Var Name
 deriving ( Eq )

type Name = String


-- B
size :: Expr -> Int
size (Num _) = 1
size (Add e1 e2) = 1 + size e1 + size e2
size (Sub e1 e2) = 1 + size e1 + size e2


---- 1 ----
-- A
data File = Data (String, Integer) | Dir (String,[File])

-- B
search :: File -> Integer -> String
search (Data (name, val)) x | val == x = name
                         | otherwise = ""
search (Dir (name, [])) x  = ""
search (Dir (name, (f:fs))) x  | ans =="" = search (Dir (name, fs)) x
                              | otherwise = name ++ "/" ++ ans
                              where
                                ans = search f x

q = (Data ("z",5))
w = (Data ("x",3))
e = (Data ("y",4))
r = (Dir ("b",[w,e]))
t = (Dir ("a",[r,q]))

---- 3 ----
diff :: Expr -> Name -> Expr
diff (Num n)   x = Num 0
diff (Add a b) x = Add (diff a x) (diff b x)
diff (Mul a b) x = Add (Mul a (diff b x)) (Mul b (diff a x))
diff (Var y)   x
  | x == y       = Num 1
  | otherwise    = Num 0

instance Show Expr where
 show = showExpr

showExpr :: Expr -> String
showExpr (Var x)   = x
showExpr (Num n)   = show n
showExpr (Add a b) = showExpr a ++ "+" ++ showExpr b
showExpr (Mul a b) = showFactor a ++ "*" ++ showFactor b

showFactor :: Expr -> String
showFactor (Add a b) = "(" ++ showExpr (Add a b) ++ ")"
showFactor e         = showExpr e

instance Arbitrary Expr where
  arbitrary = sized arbExpr

arbExpr :: Int -> Gen Expr
arbExpr s =
  frequency [ (1,genNum), (1, genVar)
            , (s,genOp Add)
            , (s,genOp Mul)
        ]
  where genNum = do n <- arbitrary
                    return (Num n)
        genOp op = do a <- arbExpr s'
                      b <- arbExpr s'
                      return (op a b)
        s' = s `div` 2

genVar = elements [Var "x", Var "y", Var "z"]

-- A
numVar :: Expr -> Name -> Int
numVar (Var var) x | x == var = 1
                 | otherwise = 0
numVar (Add e1 e2) x = 0 + numVar e1 x + numVar e2 x
numVar (Num _) _ = 0
numVar (Mul e1 e2) x= 0 + numVar e1 x + numVar e2 x
numVar (Sub e1 e2) x = 0 + numVar e1 x + numVar e2 x

prop_numvar e x = numVar e x >= numVar (diff e x) x
