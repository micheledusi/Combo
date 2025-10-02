#import "../src/lib.typ": *

= Permutations

== Counting
=== Default (no repetition)
#permutations-number(5, k: 3)
#permutations-number(5, k: 5)
#permutations-number(5, k: 0)

=== With repetition
#permutations-number-with-repetition(5, k: 3)
#permutations-number-with-repetition(5, k: 5)
#permutations-number-with-repetition(5, k: 0)

=== Without repetition
#permutations-number-no-repetition(5, k: 3)
#permutations-number-no-repetition(5, k: 5)
#permutations-number-no-repetition(5, k: 0)

== Indices
=== Default (no repetition)
#permutations-indices(5, k: 3)
#permutations-indices(5, k: 5)
#permutations-indices(5, k: 0)

=== With repetition
#permutations-indices-with-repetition(5, k: 3)
#permutations-indices-with-repetition(5, k: 5)
#permutations-indices-with-repetition(5, k: 0)

=== Without repetition
#permutations-indices-no-repetition(5, k: 3)
#permutations-indices-no-repetition(5, k: 5)
#permutations-indices-no-repetition(5, k: 0)

== Elements
#let my-arr = (10, 20, 30, 40, 50)

=== Default (no repetition)
#permutations(my-arr, k: 3)
#permutations(my-arr, k: 5)
#permutations(my-arr, k: 0)

=== With repetition
#permutations-with-repetition(my-arr, k: 3)
#permutations-with-repetition(my-arr, k: 5)
#permutations-with-repetition(my-arr, k: 0)

=== Without repetition
#permutations-no-repetition(my-arr, k: 3)
#permutations-no-repetition(my-arr, k: 5)
#permutations-no-repetition(my-arr, k: 0)