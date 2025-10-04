#import "../src/lib.typ": *

= Permutations

== Counting
=== Default (no repetition)
#count-permutations(5, k: 2)
#count-permutations(5, k: 5)
#count-permutations(5, k: 0)

=== With repetition
#count-permutations-with-repetition(5, k: 2)
#count-permutations-with-repetition(5, k: 5)
#count-permutations-with-repetition(5, k: 0)

=== Without repetition
#count-permutations-no-repetition(5, k: 2)
#count-permutations-no-repetition(5, k: 5)
#count-permutations-no-repetition(5, k: 0)

== Indices
=== Default (no repetition)
#get-permutations(5, k: 2).len()
#get-permutations(5, k: 5).len()
#get-permutations(5, k: 0).len()

=== With repetition
#get-permutations-with-repetition(5, k: 2).len()
#get-permutations-with-repetition(5, k: 5).len()
#get-permutations-with-repetition(5, k: 0).len()

=== Without repetition
#get-permutations-no-repetition(5, k: 2).len()
#get-permutations-no-repetition(5, k: 5).len()
#get-permutations-no-repetition(5, k: 0).len()

== Elements
#let my-arr = (10, 20, 30, 40, 50)

=== Default (no repetition)
#get-permutations(my-arr, k: 2).len()
#get-permutations(my-arr, k: 5).len()
#get-permutations(my-arr, k: 0).len()

=== With repetition
#get-permutations-with-repetition(my-arr, k: 2).len()
#get-permutations-with-repetition(my-arr, k: 5).len()
#get-permutations-with-repetition(my-arr, k: 0).len()

=== Without repetition
#get-permutations-no-repetition(my-arr, k: 2)
#get-permutations-no-repetition(my-arr, k: 5).len()
#get-permutations-no-repetition(my-arr, k: 0).len()