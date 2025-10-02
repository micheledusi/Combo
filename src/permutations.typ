// permutations.typ
// This module implements functions to compute permutations.

#import "cartesian.typ": cartesian-product
#import "combinations.typ": combinations-indices-no-repetition

#let permutations-number-with-repetition(n, k: auto) = {
	if k == auto {
		k = n
	}
	return calc.pow(n, k)
}

#let permutations-number-no-repetition(n, k: auto) = {
	if k == auto {
		k = n
	}
	return calc.perm(n, k)
}

#let permutations-number(n, k: auto, repetition: false) = {
	if repetition {
		return permutations-number-with-repetition(n, k: k)
	} else {
		return permutations-number-no-repetition(n, k: k)
	}
}

#let permutations-indices-with-repetition(n, k: auto) = {
	if k == auto {
		k = n
	}
	if n <= 0 or k < 0 {
		return () // Empty array
	} else if k == 0 {
		return ((),) // Array with one empty array
	}
	let arrs = (array(range(n)),) * k
	return cartesian-product(..arrs)
}

#let permutations-indices-no-repetition(n, k: auto) = {
	if k == auto {
		k = n
	}
	if k > n or n <= 0 or k < 0 {
		return () // Empty array
	} else if k == 0 {
		return ((),) // Array with one empty array
	} else if k == n { // Special case: all elements are used (more efficient)
		let permutations = ((),)
		for i in range(n) {
			permutations = permutations.map(p => {
				// By taking all possible positions
				range(p.len(), -1, step: -1).map(pos => {
					// And inserting the index "i" at that position
					p.slice(0, pos) + (i, ) + p.slice(pos)
				})
			}).join()
		}
		return permutations
	}
	// In the general case:
	// 1) We first generate all combinations of size "k"
	let combinations = combinations-indices-no-repetition(n, k)
	// 2) Then, for each combination, we generate all permutations of that combination
	return combinations.map(comb => {
		let permutations = ((),)
		for i in comb {
			permutations = permutations.map(p => {
				// By taking all possible positions
				range(p.len(), -1, step: -1).map(pos => {
					// And inserting the index "i" at that position
					p.slice(0, pos) + (i, ) + p.slice(pos)
				})
			}).join()
		}
		return permutations
	}).join()
}

#let permutations-indices(n, k: auto, repetition: false) = {
	if repetition {
		return permutations-indices-with-repetition(n, k: k)
	} else {
		return permutations-indices-no-repetition(n, k: k)
	}
}

#let permutations-with-repetition(arr, k: auto) = {
	return permutations-indices-with-repetition(arr.len(), k: k)
	.map(comb => {return comb.map(i => arr.at(i))})
}

#let permutations-no-repetition(arr, k: auto) = {
	return permutations-indices-no-repetition(arr.len(), k: k)
	.map(comb => {return comb.map(i => arr.at(i))})
}

#let permutations(arr, k: auto, repetition: false) = {
	if repetition {
		return permutations-with-repetition(arr, k: k)
	} else {
		return permutations-no-repetition(arr, k: k)
	}
}