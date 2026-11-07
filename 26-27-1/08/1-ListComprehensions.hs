module ListComprehensions where

{-
Eddig rekurziót írtunk, mostantól tanulunk helyette más eszközöket
    A háttérben rekurzió történik, viszont megspórolják nekünk a sok hosszú sort

Listagenerátor: rövid és elegáns kiválogatás+másolás
    (mint látni fogjuk: kiválogatások+másolások egymásba ágyazása+kilapítása)
-}
evenSquares :: [Integer]
evenSquares = [n ^ 2 | n <- [0..], even n]
{-             \___/   \________/  \____/
                 |          |         \-- szűrőfeltétel (Bool típusú kifejezés):
                 |      generátor             milyen elemeket válogatunk ki
                 |      |       \-------- lista:
                 |      |                     mit dolgozunk fel
                 |      \---------------- minta:
                 |                            mit veszünk ki a listából
                 \----------------------- kimeneti kifejezés:
                                              mit csinálunk az elemekkel

Halmazelmélet:
> { n² | n ∈ ℕ, n páros }
Python (véges lista):
> [n ** 2 for n in range(0, x) if n % 2 == 0]

A háttérben rekurzió történik, kb. az alábbi listának felel meg:
-}
evenSquares' :: [Integer]
evenSquares' = helper [0..]
  where
    helper (n : ns)
        | even n    = n ^ 2 : helper ns
        | otherwise =         helper ns
    helper _        = []

{-
Emlékezzünk az eddig tanult beépített függvényekre (pl. sum, length)
Gyakran használhatjuk ezeket listagenerátorokkal együtt, így egyáltalán nem kell rekurziót írnunk
pl. Adjuk meg az első n négyzetszám összegét!
-}
sumSquares :: Integer -> Integer
sumSquares n = sum [i ^ 2 | i <- [1..n]]

students :: [(String, Int)] -- (név, érdemjegy)
students = [("Gerzson", 1), ("Aladár", 5), ("Jimmy", 1)]

-- Gyűjtsük ki az 1-es érdemjegyű diákok nevét!
failedNames :: [String]
failedNames = [name | (name, 1) <- students]
{-                    \_______/
        Mintaillesztés: --/
            a nem illeszkedő elemeket átugorjuk
            (beágyazott minta: a pár második komponense 1)

Általános szintaxis:
    [eredmény | minta1 <- lista1, minta2 <- lista2, ..., feltétel1, feltétel2, ...]
    (lehet akár 0 generátor vagy 0 feltétel)

Valójában bármilyen sorrendben szerepelhetnek generátorok és feltételek,
    viszont nem minden sorrend értelmes (pl. egy generátor elemére csak a generátor után lehet hivatkozni),
    és a generátorok relatív sorrendje meghatározza az eredmény sorrendjét
-}

-- Adjuk meg egy pozitív szám pozitív osztóit!
divisors :: Integer -> [Integer]
divisors n = [i | i <- [1..n], n `mod` i == 0]

-- ennek felel meg:
divisors' :: Integer -> [Integer]
divisors' n = helper [1..n]
  where
    helper (i : is)
        | n `mod` i == 0 = i : helper is
        | otherwise      =     helper is
    helper _             = []

{-
Több generátor: "mindent mindennel" / Descartes-szorzat / ciklus ciklusban
> [(a, b) | a <- "abc", b <- [1, 2]]
Vegyük észre:
    egyesével "abc" elemeihez párosítjuk [1, 2] elemeit (és nem fordítva)
    "abc" a "külső ciklus"
> [(a, b) | b <- [1, 2], a <- "abc"]
Vegyük észre:
    most egyesével [1, 2] elemeihez párosítjuk "abc" elemeit (és nem fordítva)
    [1, 2] a "külső ciklus"
-}

-- négyzet által bezárt rácspontok:
coords :: Int -> [(Int, Int)]
coords n = [(x, y) | x <- [1..n], y <- [1..n]]

{-
Dupla körmérkőzés (mérkőzés + visszavágó):
    "mindent párosítunk mindennel"
    (kivéve: a csapatok nem játszanak maguk ellen)
-}
tournament :: [String] -> [(String, String)]
tournament ls = [(a, b) | a <- ls, b <- ls, a /= b]

dominoes :: Integer -> [(Integer, Integer)]
{-
Függő generátorok: egy generátor elemétől függhetnek a
                       \________________/ következő generátorok listái
                         /                \__________________________/
                        /                   /
                       /                 /‾‾‾‾\ -}
dominoes n = [(x, y) | x <- [0..n], y <- [x..n]]
{-
Kiválasztunk egy x-et, ezt párosítjuk minden [x..n]-beli elemmel, majd megyünk tovább

Mit csinálhat?
> :t concat
concat :: [[a]] -> [a]
> concat [[1, 2], [3, 4]]
> concat [[]]
> concat [[[]]]
-}

-- rekurzívan:
concat' :: [[a]] -> [a]
concat' (xs : xss) = xs ++ concat' xss
concat' _          = []

{-
Függő generátorokkal:
    végigmegyünk az egyes listáknak az egyes elemein
    (a listagenerátor "kilapítja" nekünk)
-}
concat'' :: [[a]] -> [a]
concat'' xss = [x | xs <- xss, x <- xs]
{-                  \/    \_/  |
        xs :: [a] --/      |   \-- x :: a
                           |
                     xss :: [[a]]

Párhuzamos feldolgozás: nincs rá nyelvi elemünk
Mit csinálhat?
> :t zip
> zip "abc" [1, 2, 3]
Eltérhet a listák hossza:
> zip ['a'..'n'] [30,28..0]
Gyakori felhasználás: elemek és indexek párosítása
> zip "abcde" [0..]
-}
