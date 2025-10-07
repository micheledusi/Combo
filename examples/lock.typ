#import "../src/lib.typ" as combo: *

#let total-digits = 10
#let digits-to-choose = 4

We have a lock with a keypad that uses *#total-digits digits*. How many different *locking codes of #digits-to-choose digits* can be formed?

We need to count the number of *permutations with repetition*, which is given by the formula:
$ P^*(#total-digits, #digits-to-choose) 
= #total-digits^#digits-to-choose 
= #combo.count-permutations-with-repetition(total-digits, k: digits-to-choose) $

