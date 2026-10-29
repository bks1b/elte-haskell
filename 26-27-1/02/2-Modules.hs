-- (I.) fejléc
module Modules where

-- (II.) import deklarációk
import Data.Char

-- (III.) többi deklaráció (tetszőleges sorrendben)

-- hivatkozhatunk később deklarált függvényekre is
inc2 i = inc (inc i)

inc :: Int -> Int -- típusdeklaráció
inc i = i + 1     -- függvénydeklaráció

-- írhatunk típusdeklarációt a függvénydeklaráció után is
inc2 :: Int -> Int

{-
Interpreter:
> ghci
Könyvtárváltás:
> :cd 26-27-1/02
Kiértékelés:
> 1 + 2
> [1..10]
Parancsok:
> :t 'a'
> :t True
> :t not
> :i (+)
Betöltés:
> :l 2-Modules.hs
> inc 10
> inc2 10
> :r
> inc2 10
Kilépés:
> :q
-}
