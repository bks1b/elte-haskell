module Primes where

import Data.Maybe
import Data.List

find' = (fromJust .) . find

{-
Motiváló példa: repüljünk a félév végére, egyelőre elég a szavakat értenünk
      Hangsúly: röviden, olvashatóan megadhatunk összetett algoritmusokat

Főbb paradigmák:
    Imperatív:  utasításokat adunk   (hangsúly: "hogyan")
                (pl. C)
    Deklaratív: leírjuk az eredményt (hangsúly: "mit")
                (⊃ funkcionális, pl. Haskell)
    Sok modern nyelvben elmosódik ezeknek a határa (pl. Scala, Rust)
    Sok funkcionális elem jelen van a legtöbb modern imperatív nyelvben is (pl. magasabb rendű függvények)
-}

isMultipleOf n x    = x `mod` n == 0
removeMultiplesOf n = filter (not . isMultipleOf n)

-- https://upload.wikimedia.org/wikipedia/commons/1/1f/Animation_Sieve_of_Eratosth_HU.gif
eratosthenes (prime : remaining) =
    prime : eratosthenes (removeMultiplesOf prime remaining)

{-
Lusta kiértékelés: pl. műveletek végtelen listákkal
> [2..]
> take 10 [2..]
-}
allPrimes = eratosthenes [2..]
isPrime n = find' (>= n) allPrimes == n

-- Mit mond a Goldbach-sejtés?
goldbach n
    | n > 2 && even n = (prime, n - prime)
        where prime   = find' (\p -> isPrime (n - p)) allPrimes

{-
Mellékhatásmentesség:
    minden függvénynek van eredménye      (nincs: result.add(p))
    állapotot paraméterekben hordozhatjuk (nincs: n = n / p)
Mit csinálhat ez a függvény?
-}
mysteryFunction n
    | abs n == 1 = []
    | otherwise  = p : mysteryFunction (n `div` p)
        where p  = find' (`isMultipleOf` n) allPrimes

-- Input/output nem lesz a félévben (ezt lehet szebben, imperatív stílusban)
main = readLn >>= liftA2 (>>) (print . goldbach) (print . mysteryFunction)
