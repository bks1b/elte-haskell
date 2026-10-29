module Floating where

{-
Lebegőpontos számok: Float, Double
> :t (+)
> :t (-)
> :t (*)
> :t (/)
> 10 / 3
> :t 10 / 3
> 10 / 3 :: Float
> 10 / 3 :: Double
-}

-- mintaillesztés
isPointOne :: Double -> Bool
isPointOne 0.1 = True
isPointOne _   = False

myTrue :: Bool
myTrue = isPointOne (0.3 - 0.2)

{-
> myTrue
False
> [0.1, 0.2 .. 1]

Hatványozás (nem kell megjegyezni: https://hoogle.haskell.org/)
Az alapszám és az eredmény típusa mindig megegyezik
> :t (**)
(**) :: Floating a => a -> a -> a
    Alapszám: bármilyen lebegőpontos típus
    Kitevő: alapszám típusa
> :t (^^)
(^^) :: (Fractional a, Integral b) => a -> b -> a
    Alapszám: bármilyen tört típus (pl. lebegőpontos, racionális)
    Kitevő: bármilyen egész típus
        Miért van ez a megszorítás?
        (nem marad racionális pl. 2 ** 0.5 == sqrt 2)
> :t (^)
(^) :: (Num a, Integral b) => a -> b -> a
    Alapszám: bármilyen szám (pl. egész, lebegőpontos)
    Kitevő: bármilyen egész típus (csak nemnegatívra van definiálva)
        Miért van ez a megszorítás?
        (nem marad egész pl. 2 ^^ (-1) == 0.5)

Érdemes a (nemnegatív) egész kitevőjű hatványozást választani, ha lehet
(ezek pontosabbak, gyorshatványozást használnak)

Nincs negatív számliterál: a negálás prefix operátor
> 3 + -2
> 3 + (-2)
-}
