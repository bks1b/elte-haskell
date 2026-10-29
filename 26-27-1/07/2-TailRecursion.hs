module TailRecursion where

-- eddig: a rekurzív hívás eredményével végeztünk valamilyen műveletet (pl. x +)
sum1 :: Num a => [a] -> a
sum1 (x : xs) = x + sum1 xs
sum1 _        = 0

{-
"Lépcső": el kell jutnunk az alapesetig, aztán tudjuk kiszámolni az egyes hívások eredményét
    Emiatt "fordítva" értékelődik ki az eredmény (az alapesettől visszafelé)

sum1 [1, 2, 3]
1 + sum1 [2, 3]
    2 + sum1 [3]
        3 + sum1 []
            0
        3 + 0
    2 + 3 + 0
1 + (2 + (3 + 0))
6

Végrekurzió: a függvény eredménye maga a rekurzív hívás (nem végzünk vele műveletet)
    A részeredményt paraméterekben ("akkumulátorok") adjuk át hívások között
-}
sum2 :: Num a => [a] -> a
sum2 ls = helper ls 0
  where
    helper (x : xs) acc = helper xs (acc + x)
    helper _        acc = acc

{-
Az akkumulátorokat a kezdetleges értékektől indítjuk -> rögtön tudtunk műveleteket végezni
    Kimarad a "lépcső" második fele (nem kell tárolni a hívási helyek kontextusát)
    Nem "fordítva" értékelődik ki az eredmény
Egyik állapotból a másikba megyünk: (ls, 0) -> ... -> ([], sum ls)
    Invariáns: akkumulátor = aktuális listából hiányzó elemek összege
    Invariáns mindig teljesül -> üres lista esetén az eredeti összeg az eredmény

sum2   [1, 2, 3]
helper [1, 2, 3] (0)
helper [2, 3]    (0 + 1)
helper [3]       (0 + 1 + 2)
helper []        (0 + 1 + 2 + 3)
((0 + 1) + 2) + 3
6

Imperatív nyelvekben általában hatékonyabb (tail-call optimization)
    A Haskell ezt nem garantálja
    (TCO ellenére lusta kiértékelés miatt az akkumulátor nagyra nőhet a memóriában)
    Nem elvárás a tárgyból, hogy így oldjuk meg a feladatokat
    (a "sima rekurzió" általában olvashatóbb)

Mikor hasznos?
    Naívan lista végéhez fűzés: mindig végig kell járni az egész részeredményt
    ("a ++ b" során "a"-t végigjárjuk)
    Nem hatékony: O(n^2) műveletigény
-}
reverse1 :: [a] -> [a]
reverse1 (x : xs) = reverse1 xs ++ [x]
reverse1 _        = []

{-
Végrekurzívan: amikor egy elemet feldolgozunk, az előtte lévő elemek már az akkumulátorban vannak
    Elég egyszer bejárni a listát -> hatékony: O(n) műveletigény
-}
reverse2 :: [a] -> [a]
reverse2 ls = helper ls []
  where
    helper (x : xs) acc = helper xs (x : acc)
    helper _        acc = acc

{-
Invariáns: akkumulátor = aktuális listából hiányzó elemek fordított sorrendben

reverse2 [1, 2, 3]
helper   [1, 2, 3] []
helper   [2, 3]    [1]
helper   [3]       [2, 1]
helper   []        [3, 2, 1]
[3, 2, 1]

Mennyivel gyorsabb? (2x? 10x?)
> :set +s
> length (reverse1 [1..10000])
> length (reverse2 [1..10000])
> :unset +s
-}
