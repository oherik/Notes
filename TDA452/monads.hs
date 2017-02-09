import Data.Complex

bind :: (Float -> (Float,String)) -> (Float,String) -> (Float,String)
bind f (val,str) = (rVal,(str++rStr))
  where
    (rVal, rStr) = f val

(¤) :: (Float -> (Float, String)) -> (Float -> (Float, String)) -> Float -> (Float, String)
(¤) f g = bind f . g

f,g :: Float -> (Float, String)
f x = (x*2,"Dubblerade! ")
g x = (x*3,"Tripplade! ")
f' x = x*2
g' x = x*3

unit :: Float -> (Float, String)
unit v = (v,"")

--lift :: (Float -> Float) -> Float -> (Float, String)
--lift f x = (f x,"")

lift :: (Float -> Float) -> Float -> (Float, String)
lift f = unit . f

bind' :: (Complex Double -> [Complex Double]) -> [Complex Double] -> [Complex Double]
bind' func bs = concat $ map func bs

unit' :: (Complex Double) -> [Complex Double]
unit' v = [v]
