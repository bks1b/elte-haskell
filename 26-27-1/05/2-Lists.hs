module Lists where

{-
Listák:
    Típus szintaxis:     [elemek típusa]
    Literál szintaxis:   [elem1, elem2, ...]
    Azonos típusú elemek (homogén)
    Tetszőleges méret    (dinamikus)
    Sorrend számít
-}

listOfInts        = [1, 2, 3]                       :: [Int]
listOfBools       = [False, True, False]            :: [Bool]
listOfListsOfInts = [[1, 2], [1, 2], [3, 4]]        :: [[Int]]
listOfPairs       = [("Gerzson", 1), ("Aladár", 2)] :: [(String, Int)]
emptyList         = []                              :: [a]   -- miért?
listOfEmptyLists  = [[], []]                        :: [[a]]

{-
Hibás listák:
> [True, 1]
> [[1, 2], 3, 4]
> [[1, 2], [[3, 4]]]

Karakterláncok:
> ['a', 'b', 'c']
> :i String
type String = [Char]
> "abc"

Lista: rekurzív algebrai adattípus (később tanuljuk)
> :i []
       /------------------ egy "a" típusú elemekből álló lista lehet:
       |      /-------------- vagy az üres lista
       |      |       /------ vagy egy elem az elejére fűzve egy másik listának
     /‾‾‾‾\   /\   /‾‾‾‾‾\
data List a = [] | a : [a]

Nekünk ez mit jelent? (láncolt lista)
(:) a lista elejére ragasztó függvény (konstruktor)
> :t (:)
[1, 2, 3] == 1 : [2, 3]
          == 1 : (2 : [3])
          == 1 : (2 : (3 : []))
          == 1 : 2 : 3 : []
-}

-- []: pontosan az üres listára illeszkedik
isEmpty :: [a] -> Bool
isEmpty [] = True
isEmpty _  = False

-- zárójelben illeszthetünk mintát a 2 paraméteres (:) konstruktorra
-- legalább 1 elemű listákra illeszkedik
first :: [a] -> a
first (x : xs) = x
{-     |   \/
       |    \-- maradék:  xs :: [a]  "többes szám"
       \------- fejelem:  x  ::  a   "egyes szám"

first [1, 2, 3] == first (1 : [2, 3]) == 1
                          |   \____/
                          |      \-- xs == [2, 3]
                          \--------- x  == 1

Mi lesz "x" és "xs"?
> first [1]
> first []
-}

rest :: [a] -> [a]
rest (_ : xs) = xs

{-
Ezek léteznek beépített függvényként (https://hoogle.haskell.org/)
> :t null
> :t head
> :t tail
Warningok: parciális függvényeket igyekszünk nem használni
-}

isSingleton :: [a] -> Bool
isSingleton (_ : []) = True
isSingleton _        = False -- ide eljutunk: vagy üres, vagy legalább 2 elemű

isDoubleton :: [a] -> Bool
isDoubleton (_ : _ : []) = True
isDoubleton _            = False
