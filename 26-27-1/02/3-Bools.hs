module Bools where

{-
Logikai típus: igaz vagy hamis
> :i Bool
> :t True
> :t False
> :t not
> not True
> not False
> :t (&&)
> True && False
-}

myNot0 :: Bool -> Bool
myNot0 True  = False
myNot0 False = True

myNot1 :: Bool -> Bool
myNot1 True = False
myNot1 x    = True  -- itt "x" már csak False lehet

myNot2 :: Bool -> Bool
myNot2 True = False
myNot2 _    = True  -- ha nem használjuk -> elegánsabb _-al elhagyni

myAnd0 :: Bool -> Bool -> Bool
myAnd0 True True = True
myAnd0 True False = False
myAnd0 False True = False
myAnd0 False False = False

-- csoportosítsuk a mintákat eredmény szerint: 1 esetben True, minden más esetben False
myAnd1 :: Bool -> Bool -> Bool
myAnd1 True True = True
myAnd1 _ _       = False -- _-t többször is használhatunk
--                          (elnevezett paramétereket egy mintán belül csak egyszer)
