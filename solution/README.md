# foolang

`Main.hs` is the source file. The "FORWARD" section contains the original code, 
an implementation of the Burrows-Wheeler transform. `Obfuscated.hs` contains a 
hand-crafted obfuscation of that code and ended up as `cryptor.foo` in the 
challenge.

The encoded flag was given. To obtain the original flag, the transform had to 
be reversed. As the algorithm is quite simple, the difficulty was in 
recognizing that `cryptor.foo` is actually working Haskell which tries to look 
like something else.

## Thoughts on the obfuscation

Since Haskell code has a few obvious give-aways, I tried hard to avoid those 
and make the code look more like a typical scripting language. Also, `file` and 
text editors should not be able to detect the file type automatically.

Here are some thoughts:
 * `import` and module names are a dead giveaway. Only functions from Prelude 
   are allowed. `dict.txt` was my reference.
 * `do` is also instantly recognizable as a Haskellism ... except when it looks 
   like a BASIC-style `do ... while` or a variable as in `$do`. The popularity 
   of shell script and PHP mean that you can credibly prefix any identifier 
   with a `$`. 
 * `where` is also dangerous, so I used it only once.
 * Top-level definitions *can* be terminated with a semicolon. Thanks to `do`, 
   we can use curly braces. Both are very common in imperative languages, but 
   rarely seen in Haskell.
 * The hash (`#`) is a popular comment character. Luckily, the hash operator is 
   still available, so we turn it into the `const` function, discarding the 
   second argument. We cannot put arbitrary text behind it, only valid 
   expressions. Misleading whitespace completes the illusion.
 * While we are at it, `#!` is also available ...
 * We can make the code instantly look more object-oriented by not padding the 
   composition operator with spaces (`a . b` vs. `a.b`).
 * Nothing screams functional programming louder than application without 
   parentheses (`f a b` vs. `f(a,b)`).
 * Haskell has whitespace-sensitive syntax, but you still get a lot of freedom 
   within expressions, particularly around operators. See l. 47, for example.
 * The syntax of top-level definitions is refreshingly free of line-noise:
   `identifier <anything except operators> = ...`. We can use that to fake all 
   sorts of nonsensical "statements" at the beginning of the file, which have 
   no effect. It helps to have a "helper" function called `function`.
 * Two dashes (`--`) are the comment character, so we are free to use any 
   syntax after a C-style "pre-decrement operator".
