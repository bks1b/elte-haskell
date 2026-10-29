module Tuples where

{-
Rendezett n-esek (n ≥ 2):
    Típus szintaxis:    (típus, típus, ...)
    Literál szintaxis:  (érték, érték, ...)
    Tetszőleges típusok (heterogén) \  minden
    Állandó méret                   |  komponensnek egy
    Sorrend számít                  /  adott szerepe van
Példák:
    Rendezett pár:   (123, "abc")  :: (Int, String)
    Rendezett 3-mas: ('a', 2, 'b') :: (Char, Double, Char)
-}

-- típus szinonima
type Student = (String, Int)      -- diák:     név és érdemjegy
type Date    = (Int, String, Int) -- dátum:    év, hónap, nap
type Point   = (Double, Double)   -- 2D pont:  x, y koordináták
type LicensePlate = (String, Int) -- rendszám: betűk és számok

failed   = ("Gerzson", 1)       :: Student
today    = (2026, "október", 7) :: Date
origin   = (0, 0)               :: Point
oldPlate = ("DFR", 123)         :: LicensePlate

-- első komponens leválasztása: hogyan lehetne általánosan?
studentName :: Student -> String -- (String, Int)    -> String
xCoord      :: Point -> Double   -- (Double, Double) -> Double

{-
Típusváltozó: tetszőleges típus behelyettesíthető (parametrikus polimorfizmus)
    Egy híváson belül "a" mindig ugyanazt jelenti
Mintaillesztés: mintha literált írnánk, elnevezzük (vagy elhagyjuk _-al) a komponenseket
    Ez csak rendezett *párra* illeszkedik
-}
first :: (a, b) -> a
first (x, _) = x

{-
> studentName failed == first failed
> xCoord origin == first origin
-}

studentGrade :: Student -> Int -- (String, Int) -> Int
second       :: -- ?

dateDay :: Date -> Int -- (Int, String, Int) -> Int
third   :: -- ?

{-
Rendezett párokra léteznek beépített függvények (https://hoogle.haskell.org/)
> :t fst
> :t snd
-}
