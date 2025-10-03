#import "../src/lib.typ": *

= Permutations

== Counting
=== Default (no repetition)
#count-permutations(5, k: 3)
#count-permutations(5, k: 5)
#count-permutations(5, k: 0)

=== With repetition
#count-permutations-with-repetition(5, k: 3)
#count-permutations-with-repetition(5, k: 5)
#count-permutations-with-repetition(5, k: 0)

=== Without repetition
#count-permutations-no-repetition(5, k: 3)
#count-permutations-no-repetition(5, k: 5)
#count-permutations-no-repetition(5, k: 0)

== Indices
=== Default (no repetition)
#get-permutations(5, k: 3)
#get-permutations(5, k: 5)
#get-permutations(5, k: 0)

=== With repetition
#get-permutations-with-repetition(5, k: 3)
#get-permutations-with-repetition(5, k: 5)
#get-permutations-with-repetition(5, k: 0)

=== Without repetition
#get-permutations-no-repetition(5, k: 3)
#get-permutations-no-repetition(5, k: 5)
#get-permutations-no-repetition(5, k: 0)

== Elements
#let my-arr = (10, 20, 30, 40, 50)

=== Default (no repetition)
#get-permutations(my-arr, k: 3)
#get-permutations(my-arr, k: 5)
#get-permutations(my-arr, k: 0)

=== With repetition
#get-permutations-with-repetition(my-arr, k: 3)
#get-permutations-with-repetition(my-arr, k: 5)
#get-permutations-with-repetition(my-arr, k: 0)

=== Without repetition
#get-permutations-no-repetition(my-arr, k: 3)
#get-permutations-no-repetition(my-arr, k: 5)
#get-permutations-no-repetition(my-arr, k: 0)