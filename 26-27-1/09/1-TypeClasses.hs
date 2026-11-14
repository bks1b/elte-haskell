module TypeClasses where

sumInt :: [Int] -> Int
sumInt (x : xs) = x + sumInt xs
sumInt _        = 0

sumDouble :: [Double] -> Double
sumDouble (x : xs) = x + sumDouble xs
sumDouble _        = 0

{-
Hogyan írhatnánk egy általános "sum" függvényt, ami minden szám típusra működik?
Próbáljunk meg egy típusváltozós (*parametrikus polimorf*) definíciót írni
    Polimorf: "többalakú" (minden típus behelyettesíthető)
-}
sum' :: [a] -> a
sum' (x : xs) = x + sum' xs
sum' _        = 0

{-
Az eddig tanultakkal nem tudunk ilyet írni, pedig a (+) függvény pont így működik:
    (+) :: Int -> Int -> Int,
    (+) :: Double -> Double -> Double,
    stb.
Mi lehet a trükk?
> :i (+)
A (+) függvény a "Num" típusosztály függvénye:
    Ha az "a" típus egy példánya a "Num" típusosztálynak,
    akkor létezik egy "(+) :: a -> a -> a" függvény

A számtípusok egy közös "Num" osztályt példányosítanak, így közösek és egységesek a függvényeik:
> :i Num
(A "class" jelölésnek nincs köze az objektumorientált nyelvekből ismert osztályokhoz!)

Hogyan írhatunk megszorítást a "sum" függvényünk "a" típusváltozójára?
> :t (+)
         /-------------- változók megszorításai
         |    /---------        =>
         |    |      /-- függvény típusa
       /‾‾‾\  | /‾‾‾‾‾‾‾‾‾\
(+) :: Num a => a -> a -> a
       \_/ |
        |  \-- a:   típus (típusosztály példánya: pl. Int, Double)
        \----- Num: típusosztály

Egészítsük ki a parametrikus polimorf definíciónkat egy megszorítással!
Ezt hívjuk *ad-hoc polimorfizmusnak*:
    Megszorítást teszünk a típusváltozónkra,
    és a függvény viselkedése típusonként különböző
    (Külön van definiálva az összeadás egészekre, lebegőpontosokra, stb.)
-}
sum'' :: Num a => [a] -> a
sum'' (x : xs) = x + sum'' xs
sum'' _        = 0

{-
Milyen típusosztályok vannak még?
Ezeknek milyen példányait, függvényeit ismerjük már?

Számok => egész számok:
> :i Integral
Számok => törtszámok:
> :i Fractional
A {-# MINIMAL ... #-} sor egy pragma (megadja, hogy példányosításkor mit kell kötelezően megadnunk)
> :t (^^)
Törtszámok => lebegőpontos számok:
> :i Floating

Egyenlőségvizsgálat:
> :i Eq
Egyenlőségvizsgálat => összehasonlítás:
> :i Ord

Felsorolás (pl. pont-pont kifejezésekkel)
> :i Enum
Szöveggé alakítás (pl. GHCi-ben):
> :i Show
> show [1, 2, 3]
-}

-- több megszorítás:
showTwo :: (Show a, Show b) => a -> b -> String
showTwo x y = show x ++ " " ++ show y

-- Mit csinál a függvény?
showCmp :: (Show a, Ord a) => a -> a -> String
showCmp x y = show x ++ " " ++ rel ++ " " ++ show y
  where
    rel | x < y     = "<"
        | x > y     = ">"
        | otherwise = "=="
