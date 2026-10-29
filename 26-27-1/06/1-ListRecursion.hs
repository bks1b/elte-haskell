module ListRecursion where

{-
Rekurzió egészekkel: "előző eredmény alapján számoljuk ki"
                     (pl. mindig eggyel csökkentjük a paramétert)
                     fact n = n * fact (n - 1)
Rekurzió listákkal:  "átadjuk a részfeladatot"
                     (leválasztjuk a fejelemet, és folytatjuk a maradékkal)
-}

-- cél: length [1, 2, 3] == 3
length :: [a] -> Int
length (_ : xs) = 1 + length xs -- legalább 1 elemű
length _        = 0             -- üres

{-
length [1, 2, 3]
1 + length [2, 3]
    1 + length [3]
        1 + length []
            0
        1
    2
3

Létezik ilyen beépített függvény, de nem fogjuk használni
(pl. végtelen listára mi lehet az eredmény?)
-}

-- "a"-ra megszorítást teszünk, hogy értelmes legyen az összeadás (később tanuljuk)
sum :: Num a => [a] -> a
sum (x : xs) = x + sum xs
sum _        = 0

{-
sum [1, 2, 3]
1 + sum [2, 3]
    2 + sum [3]
        3 + sum []
            0
        3
    5
6
-}

-- cél: last [1, 2, 3] == 3
-- lehetne ilyen típussal nem parciális? (üres lista nincs kezelve)
last :: [a] -> a
last (x : []) = x       -- egyelemű lista: alapeset
last (_ : xs) = last xs -- itt már biztosan kételemű

-- cél: init [1, 2, 3] == [1, 2]
init :: -- ?
init (x : []) = -- ?
init (x : xs) = -- ?

{-
Pont-pont kifejezés: felsorolható típusból (pl. szám, karakter) számtani sorozatot alkot
Szintaxis: első 1 vagy 2 elem, és opcionálisan egy (alsó/felső) korlát
  [első elem..]
  [első elem..felső korlát]
             \-- lépésköz: 1
  [első elem, második elem..]
  [első elem, második elem..alsó vagy felső korlát]
             \-- lépésköz: első és második elem különbsége

> [1..10]
> [1, 3..10]
> [10..1]           -- lépésköz: 1
> [10, 9..1]        -- lépésköz: 9-10 = -1
> [1..]             -- végtelen lista
> [1, 3..]
> take 12 [0, 11..]
> [0.1, 0.2 .. 1]   -- lebegőpontos hiba
> [0, 0.5 .. 2.75]
[0.0,0.5,1.0,1.5,2.0,2.5,3.0] -- a lépésköz felével túlléphető a korlát
> ['a'..'z']
> ['a', 'd'..'z']
> [False ..]
> [True ..]
-}
