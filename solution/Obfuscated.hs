#!/usr/bin/fooc
module Obfuscated where

set pragma="use strict";

long n = 0;
max_iters = 10;

public static __init n = function(long n)$do
    do {
        main!interact(code);
        --max_iters; ++n;
    }
    while (max_iters > 0);
    return 0;

main =public
    repeat until 0


code = function(**undefined)
    $mocklear(+3).mangle

mangle(l) = function(list l)
    $map(head.rotkohl)
    $words!pork
    $potatoes(l++ ([toEnum(92)]))

int words(a,b) = function()
    words(a)$b

potatoes(l) = function(list l)
    $take(length(l))
    $(($rotkohl)(iterate))(l)

rotkohl[]  = []                            # set []
rotkohl(l) = (list)tail(init(l), last(l))  # unzip

mocklear(buf)
     = map(toEnum.modify.fromEnum) where
    modify(x)|x >= 65 && x <= 90
     = (int)mod(buf(x-65), 26) + 65|x >= 97 && x <= 122
     = (int)mod(buf(x-97), 26) + 97|True
     = x

barge(as'@ ~ (a:as), bs'@ ~ (b:bs)) |as'                                     ==
    [] = bs'|bs'                                                             ==
    [] = as'|a < b
       = a: barge(as,bs')|(1+2)                                              ==
    3  = b: barge(as',bs)           # gcd


list splitAt(a,b) = b:a

pork(l) | length(l)
#!/usr/bin/foolppc <<eof
    <2=l|2==2 = (\x -> barge x)
    ( (hash pork)
      (splitAt (div (length l) 2) l)
    )
eof                                                               # token = eof


function =(!)
hash h(a,b) = (h(a),h(b))

assume !a=a    # maybe not
while b=id$
    return b
