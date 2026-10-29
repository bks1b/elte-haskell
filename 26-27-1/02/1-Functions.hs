module Functions where

{-
 /---------------- függvény neve
 |      /--------- paraméter típusa  \ függvény
 |      |      /-- eredmény típusa   / típusa
/‾\    /‾\    /‾\ -}
inc :: Int -> Int
inc i = i + 1
{-  |   \___/
    |     \-- függvény törzse (újabb függvényeket alkalmazunk a paraméterekre)
    \-------- függvény paramétere (tetszőleges, kisbetűvel kezdődő név)

Érdekesség:
> :i (->)
A nyíl egy jobb-asszociatív típus konstruktor
    Ez magyarázza az alábbi jelölést (bővebben majd félév végén)

    /---------------------------------- függvény neve
    |          /----------------------- 1. paraméter típusa \
    |          |         /------------- 2. paraméter típusa | függvény típusa
    |          |         |          /-- eredmény típusa     /
/‾‾‾‾‾‾‾\    /‾‾‾‾\    /‾‾‾‾\    /‾‾‾‾\ -}
myLogBase :: Double -> Double -> Double
myLogBase x b = log x / log b

-- konstansok ("0 paraméteres függvények")
-- vessző: több függvénynek egyszerre deklaráljuk a típusát
three1, three2, three3, three4 :: Double

-- a függvények használhatóak "operátorként"
three1 = myLogBase 8 2
three2 = 8 `myLogBase` 2 -- backtickek között -> infix írásmód

-- az "operátorok" is csak függvények
three3 = 1 + 2
three4 = (+) 1 2         -- zárójelek között -> prefix írásmód

-- definiálhatunk saját "operátorokat"
(+++) :: Int -> Int -> Int
a +++ b = 2 * a + b

{-
Mintaillesztés: egyik legfontosabb eszköz a félév során
    Több definiáló egyenlőséget írunk
    Kisbetűs paraméter helyett literált írunk (pl. szám, karakter, konstruktor (pl. True, False))
    Az első illeszkedő mintához tartozó törzs adja az eredményt
    Egy minta magával vonja, hogy az előzőek nem illeszkedtek
-}

-- egyszerű példa: csak a nemnulla számokat növeljük meg
incNonzero :: Integer -> Integer
incNonzero 0 = 0
incNonzero x = x + 1 -- itt "x" már nem lehet 0
