module HigherOrderFunctions where

-- Mit csinál a függvény?
filterEvens :: Integral a => [a] -> [a]
filterEvens (x : xs)
    | even x    = x : filterEvens xs
    | otherwise =     filterEvens xs
filterEvens xs  =     xs

-- Mi változott?
filterPos :: (Num a, Ord a) => [a] -> [a]
filterPos (x : xs)
    | x > 0     = x : filterPos xs
    | otherwise =     filterPos xs
filterPos xs    =     xs

{-
Az ilyen kiválogató függvények csak a predikátumban különböznek (a -> Bool)
> :t even
> :t (> 0)
Haskellben a függvényeket ugyanolyan értékként adhatjuk át, mint a számokat, listákat, stb.
    (first-class functions: a függvények "első osztályú állampolgárok")

Ezt kihasználva létezik egy beépített, magasabb rendű "filter" függvény:
                                       \____________/
                                             /
                 /-- függvény paramétere egy függvény
                /
           /‾‾‾‾‾‾‾‾‾\ -}
filter' :: (a -> Bool) -> [a] -> [a]
filter' f (x : xs)
    | f x       = x : filter' f xs -- tovább kell adni "f"-et is!
    | otherwise =     filter' f xs
filter' _ xs    =     xs

-- sokkal rövidebben:
filter'' :: (a -> Bool) -> [a] -> [a]
filter'' f xs = [x | x <- xs, f x]

-- ezzel minden kiválogatás röviden és olvashatóan leírható:
filterEvens' :: Integral a => [a] -> [a]
filterEvens' xs = filter even xs

filterPos' :: (Num a, Ord a) => [a] -> [a]
filterPos' xs = filter (> 0) xs

{-
A programozási tételek mind léteznek beépített függvényként:
/---------------+-----------------------------------------\
| Keresés       | find   :: (a -> Bool) -> [a] -> Maybe a |
| Eldöntés      | any    :: (a -> Bool) -> [a] -> Bool    |
| Mind eldöntés | all    :: (a -> Bool) -> [a] -> Bool    |
| Kiválogatás   | filter :: (a -> Bool) -> [a] -> [a]     |
| Másolás       | map    :: (a -> b)    -> [a] -> [b]     |
\---------------+-----------------------------------------/

Tehát a magasabb rendű függvények egy újabb eszközt adnak nekünk a rekurzió helyett
    A listagenerátorokhoz hasonlóan sokkal olvashatóbb kódot eredményeznek
    Sőt, egyszerű esetekben könnyű a megfeleltetés:
-}
filterMap, filterMap' :: (a -> Bool) -> (a -> b) -> [a] -> [b]
filterMap  p f xs = [f x | x <- xs, p x]
filterMap' p f xs = map f (filter p xs)

concatMap' :: (a -> [b]) -> [a] -> [b]
concatMap' f xs = [y | x <- xs, y <- f x]

{-
Előfordulhat vizsgán, hogy nem emlékszünk egy magasabb rendű függvény nevére vagy típusára
    Hoogle-ben és GHCi-ben viszont általánosabb típusokat találunk:
> :t any
any :: Foldable t => ... -> t a -> ...
       \________/           \_/
            |                |
  "t" egy "hajtogatható"    [a]
     típuskonstruktor
       (pl. lista)

Rengeteg rekurziós mintát implementáltak nekünk:
    (ebben a félévben elég ismerni a programozási tételeket)
    (a többi beépített függvényt magunktól sem nehéz újradefiniálni)
/---------------------------------------------------\
|                 Lista + predikátum                |
+---------------------------------------------------+
| takeWhile :: (a -> Bool) -> [a] -> [a]            |
| dropWhile :: (a -> Bool) -> [a] -> [a]            |
| span      :: (a -> Bool) -> [a] -> ([a], [a])     |
| partition :: (a -> Bool) -> [a] -> ([a], [a])     |
| break     :: (a -> Bool) -> [a] -> ([a], [a])     |
+---------------------------------------------------+
|                     Két lista                     |
+---------------------------------------------------+
| zipWith   :: (a -> b -> c) -> [a] -> [b] -> [c]   |
| concatMap :: (a -> [b])    -> [a] -> [b]          |
+---------------------------------------------------+
|                      "Bájos"                      |
+---------------------------------------------------+
| groupBy   :: (a -> a -> Bool)     -> [a] -> [[a]] |
| nubBy     :: (a -> a -> Bool)     -> [a] ->  [a]  |
| sortBy    :: (a -> a -> Ordering) -> [a] ->  [a]  |
| maximumBy :: (a -> a -> Ordering) -> [a] ->   a   |
| minimumBy :: (a -> a -> Ordering) -> [a] ->   a   |
+---------------------------------------------------+
|                      Iterálás                     |
+---------------------------------------------------+
| iterate   :: (a -> a) -> a -> [a]                 |
| fix       :: (a -> a) -> a                        |
| until     :: (a -> Bool) -> (a -> a) -> a -> a    |
+---------------------------------------------------+
|                     Hajtogatás                    |
+---------------------------------------------------+
| foldr     :: (a -> b -> b) -> b -> [a] -> b       |
| foldl     ::   (b ->  a  -> b)                    |
|              -> b -> [a] -> b                     |
| scanr     :: (a -> b -> b) -> b -> [a] -> [b]     |
| scanl     ::   (b ->  a  ->  b)                   |
|              -> b -> [a] -> [b]                   |
| mapAccumL ::   (s ->  a ->  (s,  b))              |
|              -> s -> [a] -> (s, [b])              |
| unfoldr   :: (b -> Maybe (a, b)) -> b -> [a]      |
\---------------------------------------------------/
-}
