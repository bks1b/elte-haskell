module Integral where

{-
Egész számok:
    Int:     32 vagy 64 bites
    Integer: a határ a RAM
> minBound :: Int
> maxBound :: Int
> 3 ^ 100 :: Int
> 3 ^ 100 :: Integer
Mikor lehet jobb az egyik, mint a másik?
> :t length [1, 2, 3]

Osztás:
> :t 10
> 10 / 3
> 10 `div` 3
> :t 10 / 3
> :t 10 `div` 3
> 10 `mod` 3

Egyéb műveletek:
> :i (+)
> :i (-)
> :i (*)
> :i `div`
> :i `mod`
> 1 + 2 * 3
> (1 + 2) * 3
> 1 + 10 `div` 2
> (1 :: Int) + (2 :: Integer)
-}
