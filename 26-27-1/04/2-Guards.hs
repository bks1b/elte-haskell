module Guards where

-- esetszétválasztás: mit csinálhat a függvény?
f :: Int -> Int -> Int
f x y | x <= y = x
      | x >  y = y

{-
Őrfeltétel: Bool típusú kifejezés (a függvénytörzsek előtt, | után)
    Egy mintához bármennyi (0,1,2,...) őrfeltétel tartozhat
    Az eredményt az első illeszkedő mintán belüli igaz őrfeltétel törzse adja meg
    (egy mintán/őrfeltételen továbblépünk -> biztosan nem illeszkedett/hamis volt)
-}

-- tetszőleges whitespace (új sor elején legalább 1 szóköz)
min2 :: Int -> Int -> Int
min2 x y
    | x <= y = x
    | x >  y = y

-- egy illeszkedő mintán belül az "otherwise" adja az eredményt, ha előtte semmi sem teljesült
min3 :: Int -> Int -> Int
min3 x y | x <= y    = x -- if
         | otherwise = y -- else

{-
> :t otherwise
> otherwise
-}

-- ha az első mintánál nincs True -> megy a következőre
min4 :: Int -> Int -> Int
min4 x y | x <= y = x
min4 x y | x >  y = y

-- a második mintánál már biztosan x > y -> konstans True elhagyható
min5 :: Int -> Int -> Int
min5 x y | x <= y = x
min5 _ y          = y

{-
Házihoz kelleni fog: segédfüggvények
    Adjuk meg egy 1-nél nagyobb egész szám legnagyobb, magától különböző osztóját
    1 paraméteres rekurziónál probléma: ismernünk kell az eredeti számot
Megoldás: vezessünk be egy 2 paraméteres rekurzív segédfüggvényt
       /---- az egyik paraméterben megtartjuk az eredeti számot
       | /-- a másik paramétert folyamatosan csökkentjük (aktuálisan vizsgált osztó)
       | |                      \______________________/
       | |                                |              -}
helper n k | n `mod` k == 0 = k --     /‾‾‾‾‾\
           | otherwise      = helper n (k - 1)
helper :: Int -> Int -> Int

greatestDivisor :: Int -> Int
greatestDivisor n | n > 1 = helper n (n - 1)

{-
Alternatív megoldás: lokális függvénydefiníció ("where" kulcsszó)
    A "helper2" függvény máshol nem látható
    A where-n belül hivatkozhatunk a fő definíció paramétereire
-}
greatestDivisor2 :: Int -> Int
greatestDivisor2 n | n > 1 = helper2 (n - 1)
  where -- tetszőleges whitespace (új sor elején legalább 1 szóköz)
    helper2 k | n `mod` k == 0 = k
              | otherwise      = helper2 (k - 1)
