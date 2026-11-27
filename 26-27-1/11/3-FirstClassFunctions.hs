module FirstClassFunctions where

import Data.List
import Data.Ord

{-
Eddig függvénydeklarációkat írtunk, viszont valahogy paraméterként át kell adnunk őket:
- név szerint
- névtelen függvénnyel (lambda kifejezéssel)
- parciális alkalmazással (pl. operátor szelettel)
- egyéb kifejezésként (később tanuljuk, pl. kompozíció)
-}

-- név szerint:
filterEvens :: Integral a => [a] -> [a]
filterEvens xs = filter even xs
{-                      \__/
Integral a => a -> Bool --/

Lambda kifejezéssel: név nélkül megadjuk a paramétereket és a törzset
    \param1 param2 ... -> törzs
    (a típusokat kikövetkezteti a fordító)
-}
filterEvens' :: Integral a => [a] -> [a]
filterEvens' ls = filter (\x -> even x) ls
{-                       \____________/
     Integral a => a -> Bool --/

Ahány nyelv, annyi szintaxis:
    Haskell: \x y -> x + y
    C#, JS:  (x, y) => x + y
    Python:  lambda x, y: x + y
    Rust:    |x, y| x + y
    Java:    (x, y) -> x + y
    Erlang:  fun(X, Y) -> X + Y end.
    C++:     [](auto x, auto y) { return x + y; }
    PHP:     fn($x, $y) => $x + $y

Év elején még fura lehetett a nyilas jelölés:
             paraméterek     eredmény
                  |              |
          /‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\    /‾‾‾\ -}
mkList :: Int -> Int -> Int -> [Int]
mkList x y z = [x, y, z]

{-
Curryzés (Haskell Curry):
    Valójában érdekes dolog történik, amikor egy függvényt hívunk
    Minden függvény egyszerre csak egy paramétert vesz át,
    és visszaad egy újabb függvényt,
    ami a maradék paramétereket várja
                         /-- [Int]
                        //-- Int -> [Int]
                       ///-- Int -> Int -> [Int]
                      ////-- Int -> Int -> Int -> [Int]
                     ////‾‾‾‾‾‾\‾‾‾\‾‾‾\‾‾‾\
> mkList 10 20 30 == ((((mkList) 10) 20) 30)

A szóközös jelölés csak egy könnyítés nekünk:
    Így egymás után megadhatjuk egy függvény első valahány paraméterét
    (a szóköz balról zárójeleződik)
> (mkList 10) 20 30 == (mkList 10 20) 30
  \_________/          \____________/
       |                      \-- Int -> [Int]
       \-- Int -> Int -> [Int]

Tapasztaltuk már, hogy emiatt figyelnünk kell a zárójelezésre:
> show even 2
> show (even 2)
> (show even) 2

Ez indokolja a szokatlan típus jelölést is:
    A jól ismert nyíl egy kétparaméteres típuskonstruktor (paraméter -> eredmény)
    A curryzésnek megfelelően jobbra zárójeleződik
> :i (->)
infixr -1 ->
> mkList :: Int -> (Int -> (Int -> [Int]))
-}

between :: Ord a => a -> a -> a -> Bool
between l r x = l <= x && x <= r

legalDrivers :: [Int] -> [Int]
legalDrivers xs = filter (between 0 50) xs
{-                       \____________/
       (\x -> between 0 50 x) --/ -}

maxAbs :: (Num a, Ord a) => [a] -> a
maxAbs xs = maximumBy (comparing abs) xs
{-                    \_____________/
(\x y -> comparing abs x y) --/

Operátoroknál kicsit más a helyzet:
    Egy operátor két paraméterének bármelyikét elhagyhatjuk
    (ez kényelmi funkció: nem eredendő tulajdonság, mint a curryzés)
-}
filterPos :: (Num a, Ord a) => [a] -> [a]
filterPos xs = filter (> 0) xs
{-                    \___/
        (\x -> x > 0) --/ -}

filterPos' :: (Num a, Ord a) => [a] -> [a]
filterPos' xs = filter (0 <) xs
{-                     \___/
         (\x -> 0 < x) --/ -}

-- backtickes függvényhívással is működik:
intersection :: Eq a => [a] -> [a] -> [a]
intersection xs ys = filter (`elem` xs) ys
{-                          \_________/
           (\x -> x `elem` xs) --/ -}

divides :: Integral a => a -> a -> Bool
d `divides` n = n `mod` d == 0

divisors :: Integral a => a -> [a]
divisors n = filter (`divides` n) [1..n]
{-                  \___________/
  (\d -> d `divides` n) --/

Mire kell figyelni?
> (< 10)
> (<) 10
> (`divides` 2)
> divides 2
-}
