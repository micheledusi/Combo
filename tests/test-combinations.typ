#import "../src/lib.typ": *

= Combinations

== Counting
=== Default (no repetition)
#combinations-number(5, 3)
#combinations-number(5, 5)
#combinations-number(5, 0)

=== With repetition
#combinations-number-with-repetition(5, 3)
#combinations-number-with-repetition(5, 5)
#combinations-number-with-repetition(5, 0)

=== Without repetition
#combinations-number-no-repetition(5, 3)
#combinations-number-no-repetition(5, 5)
#combinations-number-no-repetition(5, 0)

== Indices
=== Default (no repetition)
#combinations-indices(5, 3)
#combinations-indices(5, 5)
#combinations-indices(5, 0)

=== With repetition
#combinations-indices-with-repetition(5, 3)
#combinations-indices-with-repetition(5, 5)
#combinations-indices-with-repetition(5, 0)

=== Without repetition
#combinations-indices-no-repetition(5, 3)
#combinations-indices-no-repetition(5, 5)
#combinations-indices-no-repetition(5, 0)

== Elements
#let my-arr = (10, 20, 30, 40, 50)

=== Default (no repetition)
#combinations(my-arr, 3)
#combinations(my-arr, 5)
#combinations(my-arr, 0)

=== With repetition
#combinations-with-repetition(my-arr, 3)
#combinations-with-repetition(my-arr, 5)
#combinations-with-repetition(my-arr, 0)

=== Without repetition
#combinations-no-repetition(my-arr, 3)
#combinations-no-repetition(my-arr, 5)
#combinations-no-repetition(my-arr, 0)