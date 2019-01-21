module Main where

import Data.Char
import Data.List

import Test.SmallCheck

import qualified Obfuscated as Ob


end      = '\\'
test     = "^BANANA"
solution = "Nice one. The fl@g is: hxp{i-kn0w/my.PLANs}"


main = do
    smallCheck 1 prop_bwtExample
    smallCheck 1 prop_codeExample
    smallCheck 5 prop_bwtInverse
    smallCheck 5 prop_codeInverse
    smallCheck 5 prop_codeObfuscated
    smallCheck 5 prop_sortEq

    putStrLn ""
    print solution
    print $ Ob.code solution
    print $ decode $ code solution

    writeFile "enc.bin" $ Ob.code solution


--- FORWARD -------------------------------------------------------------------

code = mapLetters (+3) . bwt

bwt l
    = map (head . rotCol)
    $ sort
    $ rotations (l ++ [end])

rotations l
    = take (length l)
    $ iterate rotCol l

rotCol :: [t] -> [t]
rotCol [] = []
rotCol l  = let (abc,z) = (init l, last l)
            in  z:abc

mapLetters f = map (chr . modify . ord)  where
    modify x | x >= 65 && x <=  90 = (f (x-65) `mod` 26) + 65
             | x >= 97 && x <= 122 = (f (x-97) `mod` 26) + 97
             | otherwise           = x


--- BACKWARDS -----------------------------------------------------------------

decode = inverseBwt . mapLetters (\x -> x - 3)

inverseBwt :: String -> String
inverseBwt l
    = init
    $ head
    $ filter (\l -> last l == end)
    $ (!! len)
    $ iterate (sort . ins col) tab
  where
    len = length l
    col = transpose [l]
    tab = replicate len []

    ins :: [[a]] -> [[a]] -> [[a]]
    ins l tab = zipWith (++) l tab


--- TESTS ---------------------------------------------------------------------

prop_bwtExample     = bwt "^BANANA" == "BNN^AA"++[end]++"A"
prop_codeExample    = let l = ['\00'..'\255'] in decode (code l) == l
prop_bwtInverse     = \l -> inverseBwt (bwt  l) == l
prop_codeInverse    = \l -> decode     (code l) == l
prop_codeObfuscated = \l -> code l == Ob.code l
prop_sortEq         = \l -> Ob.pork l == sort (l :: [Int])
