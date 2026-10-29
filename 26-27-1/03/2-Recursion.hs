module Recursion where

{-
Rekurzió: egy függvény önmagára hivatkozik, pl.:
    előző eredményekből számoljuk ki az újat  (pl. faktoriális),
    lebontunk egy feladatot részfeladat(ok)ra (pl. rendezés, bejárás)
-}

-- előző szám faktoriálisát már ismerjük: ezt csak megszorozzuk n-nel
fact :: Integer -> Integer
fact 0 = 1                -- alapeset (mi történne nélküle?)
fact n = n * fact (n - 1)

{-
fact 4
4 * fact 3
    3 * fact 2
        2 * fact 1
            1 * fact 0
                1
            1
        2
    6
24
-}

-- előző két Fibonacci számot már ismerjük: ezeket összeadjuk
fib :: Int -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)
