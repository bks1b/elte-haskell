module ParametricADTs where

{-
Párszor találkoztunk már futási idejű hibával:
> 5 `div` 2
> 5 `div` 0
"Errors as values" (pl. Rust, Go, Haskell, Erlang):
    Kerüljük a futási idejű hibákat, parciális függvényeket
    Helyette a hibákat is értékként kezeljük
A sikert és a hibát ADT-vel különböztetjük meg:
-}
data DivResult = DivSuccess Int | DivError
{-               \____________/   \______/
                       |             |
        van eredmény --/           nincs
        (adattagban)              eredmény
-}

-- fordításkor, típus szinten tudjuk, hogy egy függvény adhat-e sikertelen eredményt
safeDiv :: Int -> Int -> DivResult
safeDiv _ 0 = DivError
safeDiv n m = DivSuccess (n `div` m)

-- elegáns hibakezelés (mintát illesztünk a 0 újbóli ellenőrzése helyett)
incSafeDiv :: Int -> Int -> DivResult
incSafeDiv n m = helper (n `safeDiv` m)
  where
    helper (DivSuccess x) = DivSuccess (x + 1)
    helper x              = x -- DivError-t változatlanul hagyjuk

{-
Milyen parciális függvényekkel találkoztunk még?
> 5 ^ (-1)
> head []
> tail []
> minimum []
-}

-- Terjesszük ki az előbbi típust, hogy tetszőleges "a" típusú eredménye lehessen!
data Result a = Success a | Error
{-   \____/ |
        |   \-- típusparaméter
        \------ típuskonstruktor (paraméterből konstruál egy típust)

Érdekesség: látszik a kind-ból, hogy "Result"-nak egy típusparamétere van
    (kind: "típus típusa")
> :i Bool
type Bool :: *
> :i Result
type Result :: * -> *

Találkoztunk már parametrikus algebrai adattípussal:
> :i []
data List a = [] | a : [a]
> :i (,)
data Tuple2 a b = (,) a b

Valójában létezik egy beépített "Maybe" típus:
> :i Maybe
        /------------------- Talán van "a" típusú eredmény:
        |         /------------ nincs eredmény
        |         |         /-- van eredmény (adattagban)
        |         |         |
     /‾‾‾‾‾\   /‾‾‾‾‾\   /‾‾‾‾\
data Maybe a = Nothing | Just a

Mi lesz a konstruktorok típusa?
> :t Just
> :t Nothing

Mikor lehet hasznos?
> import Data.List
> import Data.Maybe
> :t listToMaybe
> :t uncons
> :t elemIndex
> :t lookup
> :t stripPrefix
-}

-- listToMaybe
safeHead :: [a] -> Maybe a
safeHead (x : _) = Just x
safeHead _       = Nothing

safeTail :: [a] -> Maybe [a]
safeTail (_ : xs) = Just xs
safeTail _        = Nothing

{-
Mit fejez ki az alábbi típus?
> :i Either
data Either a b = Left a | Right b

Ez egy általánosabb Maybe: "Nothing" helyett "Left a" van
    Tehát a hibának is adhatunk egy értéket (pl. hibaüzenetet String-ként)
-}
safePower :: (Num a, Integral b) => a -> b -> Either String a
safePower x i | i < 0     = Left "Negative exponent"
              | otherwise = Right (x ^ i)
