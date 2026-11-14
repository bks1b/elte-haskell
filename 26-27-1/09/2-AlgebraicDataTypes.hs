module AlgebraicDataTypes where

import Data.List

exec :: Eq a => String -> a -> [a] -> [a]
exec "prepend" x xs = x : xs
exec "append"  x xs = xs ++ [x]
exec "delete"  x xs = delete x xs

{-
Ötlet: vezessünk be egy saját típust Stringek használata helyett
Mi is egy típus?
    A lehetséges értékek halmaza (pl. 0, 1, 2, ...),
    és az elvégezhető műveletek  (pl. összeadás, szorzás)
A "data" kulcsszóval saját adattípust definiálhatunk:
-}
data Operation = Prepend | Append | Delete
{-   \_______/   \_____/   \____/   \____/
         |          |         |        |
         |          \---------+--------+-- adatkonstruktorok (lehetséges értékek)
         \-------------------------------- típus neve
                                           \_______________/
                                             mind nagybetű!

Miért jobb így?
    Véd minket az elgépeléstől (pl. Append helyett Apend fordítási hiba lenne)
    Nem parciális a függvény   (minden Operation-re illeszkedik egy minta)
    Hatékonyabb a függvény     (Stringeket összehasonlítani költséges lehet)
    Beszédesebb a kód          (a típusból látszik, hogy mi az első paraméter)
-}
exec' :: Eq a => Operation -> a -> [a] -> [a]
exec' Prepend x xs = x : xs
exec' Append  x xs = xs ++ [x]
exec' Delete  x xs = delete x xs

{-
Valójában tetszőleges adattagokat adhatunk az egyes adatkonstruktoroknak
    (tetszőleges típusúak lehetnek, minden adattagnak egy adott szerepe van)
    (az egyes konstruktorok adattagjai teljesen függetlenek)
Egy "Shape" típusú értéknek három fajtája lehet, az egyes fajták különböző adatokat hordoznak
    (a körnek sugara, a téglalapnak két oldala, a háromszögnek három oldala van)
-}
data Shape = Circle Double | Rectangle Double Double | Triangle Double Double Double

-- adatkonstruktorokkal tudunk "konstruálni" egy "Shape" típusú értéket
myShapes :: [Shape]
myShapes = [Circle 10, Rectangle 2 5, Triangle 1 2 3]

{-
Mi lehet az egyes konstruktorok típusa? (a fenti szintaxis segít)
> :t Circle
> :t Rectangle
> :t Triangle
-}

-- mintaillesztés: zárójelben, konstruktor neve után írjuk az adattagok mintáit
area :: Shape -> Double
area (Circle r)       = r ^ 2 * pi
area (Rectangle a b)  = a * b
area (Triangle a b c) = sqrt (s * (s - a) * (s - b) * (s - c))
  where
    s = (a + b + c) / 2

{-
Miért *algebrai* adattípus?
Egy ilyen összetett típust lebonthatunk elemi típusokra (ilyen elemi típusokkal találkoztunk már)

Összeg típus ("VAGY"):
    Felsoroljuk a lehetséges értéket
    (több adatkonstruktor 0 adattaggal)
> :i Bool
data Bool = False | True

Szorzat típus ("ÉS"):
    Több típus Descartes-szorzatát vesszük
    (egyesével bármilyen értéket választhatunk az egyes típusokból)
    (1 adatkonstruktor több adattaggal)
> :i (,)
data Tuple2 a b = (,) a b
> :i (,,)
data Tuple3 a b c = (,,) a b c

Mi történik, ha kiíratunk egy Operation értéket, vagy egyenlőséget vizsgálunk?
> Prepend
> Prepend == Prepend

A típusunknak nincs sem Show, sem Eq példánya
    Megoldás: "deriving" kulcsszóval a fordító automatikusan példányosítja nekünk
-}
data Operation' = Prepend' | Append' | Delete' deriving (Show, Eq)
{-
> Prepend'
> show Prepend'
> Prepend' == Prepend'

Néhány automatikusan példányosítható típusosztály:
    Show, Eq, Enum,
    Ord (konstruktorok sorrendje, azon belül adattagok alapján)

Hogyan nézne ki a manuális példányosítás?
-}
instance Show Operation where
    show Prepend = "Prepend"
    show Append  = "Append"
    show Delete  = "Delete"

instance Eq Operation where
    Prepend == Prepend = True
    Append  == Append  = True
    Delete  == Delete  = True
    _       == _       = False

data Day = Mon | Tue | Wed | Thu | Fri | Sat | Sun deriving (Eq, Enum)

-- beépített függvények gyakran Eq-t használnak, hogy általánosak maradjanak:
isWeekend :: Day -> Bool
isWeekend x = x `elem` [Sat, Sun]

-- automatikus Enum példány kihasználása:
tomorrow :: Day -> Day
tomorrow Sun = Mon
tomorrow x = succ x
