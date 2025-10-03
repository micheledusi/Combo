// permutations.typ
// This module implements functions to compute permutations.

#import "cartesian.typ": cartesian-product
#import "combinations.typ": get-combinations-no-repetition

// Counts the *number of permutations with repetition*.
// Returns the number of possible permutations when choosing $k$ items from $n$ distinct items, allowing repetitions.
// -> int
#let count-permutations-with-repetition(
	// The array of distinct items, or the total number of distinct items.
	// Both an array and an integer are accepted. In the case of an array, its length is used. In the case of an integer, it must be a non-negative integer.
	// -> int | array
	items, 
	// The number of items to choose, among the $n$ distinct items.
	// Must be a non-negative integer.
	// -> int
	k: auto,
) = {
	if type(items) == array {
		items = items.len()
	}
	if k == auto {
		k = items
	}
	return calc.pow(items, k)
}

// Calculates the number of permutations without repetition.
// Returns the number of possible permutations when choosing $k$ items from $n$ distinct items, without allowing repetitions.
// -> int
#let count-permutations-no-repetition(
	// The array of distinct items, or the total number of distinct items.
	// Both an array and an integer are accepted. In the case of an array, its length is used. In the case of an integer, it must be a non-negative integer.
	// -> int | array
	items, 
	// The number of items to choose, among the $n$ distinct items.
	// Must be a non-negative integer.
	// -> int
	k: auto,
) = {
	if type(items) == array {
		items = items.len()
	}
	if k == auto {
		k = items
	}
	return calc.perm(items, k)
}

// Computes the *number of permutations* of $n$ elements taken $k$ at a time.
// The order of elements matters, and each element can be chosen only once unless repetition is allowed (by setting `repetition` to #(true)). 
// - If `repetition` is #(false), the number is computed using the formula for *permutations without repetition* implemented as the `perm` function in the `calc` module:
// 	$ P(n, k) = n! / (n - k)! = "perm"(n, k) $
// - If `repetition` is #(true), the number is computed using the formula for *permutations with repetition*:
// 	$ n^k = "pow"(n, k) $	
// The returned number is given as an *integer*.
// -> int
#let count-permutations(
	// The array of distinct items, or the total number of distinct items.
	// Both an array and an integer are accepted. In the case of an array, its length is used. In the case of an integer, it must be a non-negative integer.
	// -> int | array
	items, 
	// The number of items to choose, among the $n$ distinct items.
	// Must be a non-negative integer.
	// -> int
	k: auto, 
	// Whether to allow repetition of elements in the permutations.
	// If #(true), elements can be chosen multiple times. If #(false), each element can be chosen only once.
	// Default is #(false).
	// -> bool
	repetition: false,
) = {
	if repetition {
		return count-permutations-with-repetition(items, k: k)
	} else {
		return count-permutations-no-repetition(items, k: k)
	}
}

// Generates all *permutations with repetition* of $n$ elements taken $k$ at a time.
// The order of elements matters, and each element can be chosen multiple times.
// The list of permutations is represented as an array of tuples, where each tuple contains the indices of the chosen elements.
// Indices are zero-based, meaning they start from 0 up to $n-1$.
// If $k$ is not provided or set to #(auto), it defaults to $n$, generating permutations that use all elements.
// The function returns an empty list if either $n$ or $k$ is negative.
// -> array(array(int | any))
#let get-permutations-with-repetition(
	// The array of distinct items, or the total number of distinct items.
	// Both an array and an integer are accepted. In the case of an integer, it is interpreted as the total number of distinct items from $0$ to $n-1$.
	// -> int | array
	items, 
	// The number of items to choose, among the $n$ distinct items.
	// Must be a non-negative integer.
	// -> int
	k: auto,
) = {
	let n = if type(items) == array {items.len()} else {items}
	if k == auto {
		k = n
	}
	if n <= 0 or k < 0 {
		return () // Empty array
	} else if k == 0 {
		return ((),) // Array with one empty array
	}
	let arrs = (array(range(n)),) * k
	let permutations = cartesian-product(..arrs)
	if type(items) == array {
		return permutations.map(comb => {return comb.map(i => items.at(i))})
	} else {
		return permutations
	}
}

// Generates all *permutations without repetition* of $n$ elements taken $k$ at a time.
// The order of elements matters, and each element can be chosen only once.
// The list of permutations is represented as an array of tuples, where each tuple contains the indices of the chosen elements.
// Indices are zero-based, meaning they start from 0 up to $n-1$.
// If $k$ is not provided or set to #(auto), it defaults to $n$, generating permutations that use all elements.
// The function returns an empty list if $k$ is greater than $n$, or if either $n$ or $k$ is negative.
// If $k$ is 0, the function returns a list containing an empty tuple, representing the single permutation of choosing nothing.
// If $k$ equals $n$, a more efficient algorithm is used to generate all permutations of the entire set.
// In the general case where $0 < k < n$, the function first generates all combinations of size $k$, and then generates all permutations for each combination.
// The result is an array of tuples, where each tuple contains the indices of the chosen elements.
//
// -> array(array(int | any))
#let get-permutations-no-repetition(
	// The array of distinct items, or the total number of distinct items.
	// Both an array and an integer are accepted. In the case of an integer, it is interpreted as the total number of distinct items from $0$ to $n-1$.
	// -> int | array
	items, 
	// The number of items to choose, among the $n$ distinct items.
	// Must be a non-negative integer.
	// -> int
	k: auto,
) = {
	let n = if type(items) == array {items.len()} else {items}
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
	let permutations = get-combinations-no-repetition(n, k)
	// 2) Then, for each combination, we generate all permutations of that combination
	permutations = permutations.map(comb => {
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
	if type(items) == array {
		return permutations.map(comb => {return comb.map(i => items.at(i))})
	} else {
		return permutations
	}
}

// Generates all permutations of $n$ elements taken $k$ at a time.
// The order of elements matters. By default, each element can be chosen only once, but this can be changed by setting `repetition` to #(true). 
// The list of permutations is represented as an array of tuples, where each tuple contains the indices of the chosen elements.
// Indices are zero-based, meaning they start from 0 up to $n-1$.
// If $k$ is not provided or set to #(auto), it defaults to $n$, generating permutations that use all elements.
// The function returns an empty list if $k$ is greater than $n$ when `repetition` is #(false), or if either $n$ or $k$ is negative.
// If $k$ is 0, the function returns a list containing an empty tuple, representing the single permutation of choosing nothing.
// - If `repetition` is #(false), permutations are generated without allowing any element to be chosen more than once.
// - If `repetition` is #(true), permutations are generated allowing elements to be chosen multiple times. 
// -> array(array(int | any))
#let get-permutations(
	// The array of distinct items, or the total number of distinct items.
	// Both an array and an integer are accepted. In the case of an integer, it is interpreted as the total number of distinct items from $0$ to $n-1$.
	// -> int | array
	items, 
	// The number of items to choose, among the $n$ distinct items.
	// Must be a non-negative integer.
	// -> int
	k: auto,
	// Whether to allow repetition of elements in the permutations.
	// If #(true), elements can be chosen multiple times. If #(false), each element can be chosen only once.
	// Default is #(false).
	// -> bool
	repetition: false,
) = {
	if repetition {
		return get-permutations-with-repetition(items, k: k)
	} else {
		return get-permutations-no-repetition(items, k: k)
	}
}
