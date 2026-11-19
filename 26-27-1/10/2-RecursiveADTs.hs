module RecursiveADTs where

{-
Emlékezzünk vissza a listák deklarációjára:
> :i []
      /------------------- egy "a" típusú elemekből álló lista lehet:
      |     /---------------- vagy az üres lista
      |     |      /--------- vagy egy elem az elejére fűzve egy másik listának
     /‾\   /\   /‾‾‾‾‾\
data [a] = [] | a : [a]

Informálisan kezdjük el kibontani ezt a definíciót (valójában ez nem értelmes Haskell):
    data [a] = [] | a:[a]
    data [a] = [] | a:[] | a:a:[a]
    data [a] = [] | a:[] | a:a:[] | a:a:a:[a]
    data [a] = [] | a:[] | a:a:[] | a:a:a:[] | a:a:a:a:[a]
    data [a] = [] | a:[] | a:a:[] | a:a:a:[] | a:a:a:a:[] | ...
Tehát előbb-utóbb minden elemszámú lista előáll ebből a rekurzív definícióból
-}

-- egyszerűen tudjuk utánozni a beépített listákat:
data List a = Nil | Cons a (List a)
infixr 5 `Cons`

{-
Ha az elemeket show-olni szeretnénk, kell egy megszorítást írnunk az elemek típusára
    (így csak olyan lista lesz show-olható, aminek az elemei is azok)
-}
instance Show a => Show (List a) where
  -- ne lepődjünk meg, hogy a függvény rekurzív lesz
  show ls = "[" ++ drop 1 (helper ls) ++ "]"
    where
      helper (x `Cons` xs) = "," ++ show x ++ helper xs
      helper _             = ""
