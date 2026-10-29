module NestedPatterns where

{-
Eddigi mintaillesztés:
  Paraméterek névhez kötése:
    inc i = i + 1
  Mintaillesztés literálokra/konstruktorokra:
    isZero 0   = True
    isEmpty [] = True
    not True   = False
  Paraméteres konstruktorok: nevekhez kötöttük, vagy _-al elhagytuk a paramétereiket
    head (x : _) = x
    snd  (_, x)  = x
-}

-- ezt lehet tetszőleges mélységig folytatni: névhez kötés helyett újabb mintákat írunk
headIsOne :: [Integer] -> Bool
headIsOne (1 : _) = True
headIsOne _       = False

fstIsOne :: (Integer, a) -> Bool
fstIsOne (1, _) = True
fstIsOne _      = False

-- Mondjunk paramétereket, amelyekre a függvények 1-et adnak!
f (_ : [])         = 1
g (True : xs)      = 1
h (x : 2 : _)      = 1
i ((_, (_, 3)), _) = 1
j ([] : xss)       = 1
k ((1 : xs) : xss) = 1
l (1 : (x : xs))   = 1
m (x : xs, y : []) = 1
n ((1, True) : _)  = 1
o (((x : [], 1 : _, False) : []) : [(y : _, [], True)] : _) = 1
