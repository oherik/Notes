---- 0 ----
-- a) eval (Lit 67) = 67
-- b) eval (Add (Sub (Lit 3) (Lit 1)) (Lit 3)) = eval (Sub (Lit 3) (Lit 1))
-- + eval (Lit 3) = eval Lit 3 - eval Lit 1 + eval Lit 3 = 3 - eval Lit 1 + eval Lit 3 = 3 - 1 + eval Lit 3 = 2 + eval Lit 3 = 2 + 3 = 5
-- c) Palla jag fattar

data Expr = Num Int | Add Expr Expr | Sub Expr Expr

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
