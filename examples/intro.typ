#import "../src/lib.typ" as combo: *

#let items = (
	emoji.apple, 
	emoji.banana, 
	emoji.cherries, 
	emoji.peach, 
	emoji.watermelon,
)
#let n = items.len()

Consider the following *set of distinct items*: 
$ F = {#items.join(", ")} $
with cardinality $|F|=#n$. 

#let k = 3
How many ways can we choose *$k=#k$ different items* from this list?

$ binom(|F|, k) = (|F|!)/(k! dot (|F|-k)!) = binom(#[#n], #k) = #n!/(#k! dot #(n - k)!) = #combo.count-combinations(n, k) $

Let's list all of them:

#for c in combo.get-combinations(items, k) {
	[ + ${#c.join(", ")}$ ]
}