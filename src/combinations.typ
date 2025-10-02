// combinations.typ
// This module implements functions to compute combinations.


// Calculates the number of combinations with repetition.
// Returns the number of possible combinations when choosing $k$ items from $n$ distinct items, allowing repetitions.
// 
// -> int
#let combinations-number-with-repetition(
	// The total number of distinct items.
	// Must be a non-negative integer.
	// -> int
	n, 
	// The number of items to choose, among the $n$ distinct items.
	// Must be a non-negative integer.
	// -> int
	k,
) = {
	return calc.binom(n + k - 1, k)
}

// Calculates the number of combinations without repetition.
// Returns the number of possible combinations when choosing $k$ items from $n$ distinct items, without allowing repetitions.
//
// -> int
#let combinations-number-no-repetition(
	// The total number of distinct items.
	// Must be a non-negative integer.
	// -> int
	n, 
	// The number of items to choose, among the $n$ distinct items.
	// Must be a non-negative integer.
	// -> int
	k,
) = {
	return calc.binom(n, k)
}

// Computes the *number of combinations* of $n$ elements taken $k$ at a time.
// The order of elements does not matter, and each element can be chosen only once unless repetition is allowed (by setting `repetition` to #(true)). 
// 
// - If `repetition` is #(false), the number is computed using the *binomial coefficient formula* (also known as _"n choose k"_) implemented as the `binom` function in the `calc` module:
// 	$ C(n, k) = n! / (k! dot (n - k)!) = "binom"(n, k) $
// - If `repetition` is #(true), the number is computed using the formula for *combinations with repetition*:
// 	$ C(n + k - 1, k) = "binom"(n + k - 1, k) $
// 
// The returned number is given as an *integer*. 
// 
// -> int
#let combinations-number(
	// The total number of elements in the set.
	// Must be a non-negative integer.
	// -> int
	n, 
	// The number of elements to choose from the set.
	// Must be a non-negative integer.
	// -> int
	k, 
	// Whether to allow repetition of elements in the combinations.
	// If #(true), elements can be chosen multiple times. If #(false), each element can be chosen only once.
	// Default is #(false).
	repetition: false,
) = {
	if repetition {
		return combinations-number-with-repetition(n, k)
	} else {
		return combinations-number-no-repetition(n, k)
	}
}

// Computes the list of combinations of $k$ elements from a set of $n$ elements, allowing repetition.
// The list of combinations is represented as an array of tuples, where each tuple contains the indices of the chosen elements.
// Indices are zero-based, meaning they start from 0 up to $n-1$.
// The number of combinations is computed using the formula for combinations with repetition:
// $ C(n + k - 1, k) = "binom"(n + k - 1, k) = (n + k - 1)! / (k! dot (n - 1)!) $
//
// -> array(array(int))
#let combinations-indices-with-repetition(
	// The total number of distinct elements in the set.
	// Must be a non-negative integer.
	// -> int
	n, 
	// The number of items to choose from the $n$ distinct elements.
	// Must be a non-negative integer.
	// -> int
	k,
) = {
	if k == 0 {
		// If k is 0, return an empty combination
		return ((), )
	} else if k < 0 or n < 0 {
		// If k or n is negative, panic with an error message
		panic("k and n must be non-negative integers")
	} else if n == 0 {
		// If n is 0, no combinations possible unless k is 0
		return ()
	}
	let combinations = range(n).map(i => (i,))
	for j in range(k - 1) {
		combinations = combinations
			.map(comb => {
				let start = comb.last()
				return range(start, n).map(i => comb + (i,))
			})
			.join()
	}
	return combinations
}

// Computes the list of combinations of $k$ elements from a set of $n$ elements, without allowing repetition. As in combinations, the order of elements does not matter.
// The list of combinations is represented as an array of tuples, where each tuple contains the indices of the chosen elements.
// Indices are zero-based, meaning they start from 0 up to $n-1$.
//
// -> array(array(int))
#let combinations-indices-no-repetition(
	/// The total number of distinct elements in the set.
	/// Must be a non-negative integer.
	/// -> int
	n,
	/// The number of items to choose from the $n$ distinct elements.
	/// Must be a non-negative integer.
	/// -> int
	k, 
) = {
	if k == 0 {
		// If k is 0, return an empty combination
		return ((), )
	} else if k > n {
		// If k is greater than n, return an empty set
		return ()
	} else if k < 0 or n < 0 {
		// If k or n is negative, panic with an error message
		panic("k and n must be non-negative integers")
	}
	let combinations = range(n).map(n => (n, ))
	for _ in range(k - 1) { // for "k - 1" times
		combinations = combinations
			.map(comb => {
				return range(comb.last() + 1, n).map(i => comb + (i, ))
			})
			.join()
	}
	return combinations
}

// Computes the *list of combinations* of indices for choosing $k$ elements from a set of $n$ elements.
// The order of elements does not matter, and each element can be chosen only once unless repetition is allowed (by setting `repetition` to #(true)). 
// The result is a list of tuples, where each tuple contains the indices of the chosen elements. 
// Indices are zero-based, meaning they start from 0 up to $n-1$.
// 
// - If `repetition` is #(false), combinations are generated without allowing any element to be chosen more than once.
// - If `repetition` is #(true), combinations are generated allowing elements to be chosen multiple times.
// The function returns an empty list if $k$ is greater than $n$ when `repetition` is #(false), or if either $n$ or $k$ is negative.
// If $k$ is 0, the function returns a list containing an empty tuple, representing the single combination of choosing nothing.
// 
// -> array(array(int))
#let combinations-indices(
	// The number of distinct elements in the set.
	// Must be a non-negative integer.
	// -> int
	n, 
	// The number of elements to choose from the $n$ distinct elements.
	// Must be a non-negative integer.
	// -> int
	k, 
	// Whether to allow repetition of elements in the combinations.
	// If #(true), elements can be chosen multiple times. If #(false), each element can be chosen only once.
	// Default is #(false).
	repetition: false,
) = {
	if repetition {
		return combinations-indices-with-repetition(n, k)
	} else {
		return combinations-indices-no-repetition(n, k)
	}
}

// Computes the list of combinations of elements from the input array `arr`, choosing $k$ elements at a time, allowing repetition.
// The list of combinations is represented as an array of tuples, where each tuple contains the chosen elements.
// This function relies on `combinations-indices-with-repetition` to generate the indices of the combinations, and then maps those indices to the actual elements in `arr`.
// 
// The number of combinations is computed using the formula for combinations with repetition:
// $ C(n + k - 1, k) = "binom"(n + k - 1, k) = (n + k - 1)! / (k! dot (n - 1)!) $
// where $n$ is the length of the input array `arr`.
// 
// *Note*: this function assumes that the input array `arr` contains distinct elements. The presence of duplicate elements in the input array is not strictly forbidden, but is treated as distinct based on their indices.
// 
// -> array(array(any))
#let combinations-with-repetition(
	// The input array from which to choose elements.
	// The array can contain elements of any type.
	// -> array(any)
	arr, 
	// The number of elements to choose from the input array.
	// Must be a non-negative integer.
	// -> int
	k,
) = {
	return combinations-indices-with-repetition(arr.len(), k)
	.map(comb => {return comb.map(i => arr.at(i))})
}

// Computes the list of combinations of elements from the input array `arr`, choosing $k$ elements at a time, without allowing repetition.
// The list of combinations is represented as an array of tuples, where each tuple contains the chosen elements.
// This function relies on `combinations-indices-no-repetition` to generate the indices of the combinations, and then maps those indices to the actual elements in `arr`.
// 
// The number of combinations is computed using the binomial coefficient formula implemented in the `calc.binom` function:
// $ C(n, k) = n! / (k! dot (n - k)!) = "binom"(n, k) $
// where $n$ is the length of the input array `arr`.
// 
// *Note*: this function assumes that the input array `arr` contains distinct elements. The presence of duplicate elements in the input array is not strictly forbidden, but is treated as distinct based on their indices.
// 
// -> array(array(any))
#let combinations-no-repetition(
	// The input array from which to choose elements.
	// The array can contain elements of any type.
	// -> array(any)
	arr, 
	// The number of elements to choose from the input array.
	// Must be a non-negative integer.
	// -> int
	k,
) = {
	return combinations-indices-no-repetition(arr.len(), k)
	.map(comb => {return comb.map(i => arr.at(i))})
}

// Computes the *list of combinations* of elements from the input array `arr`, choosing $k$ elements at a time.
// The order of elements does not matter, and each element can be chosen only once unless repetition is allowed (by setting `repetition` to #(true)). 
// The result is a list of tuples, where each tuple contains the chosen elements.
// 
// *Note*: this function assumes that the input array `arr` contains distinct elements. The presence of duplicate elements in the input array is not strictly forbidden, but is treated as distinct based on their indices.
// 
// - If `repetition` is #(false), combinations are generated without allowing any element to be chosen more than once. The number of possible combinations is given by the binomial coefficient formula implemented in the `calc.binom` function.
// 	$ C(n, k) = n! / (k! dot (n - k)!) = "binom"(n, k) $
// 	where $n$ is the length of the input array `arr`.
// - If `repetition` is #(true), combinations are generated allowing elements to be chosen multiple times. The number of possible combinations is given by the formula for combinations with repetition:
// 	$ C(n + k - 1, k) = "binom"(n + k - 1, k) $
// 	where $n$ is the length of the input array `arr`.
// 
// The function returns an empty list if $k$ is greater than the length of `arr` when `repetition` is #(false), or if either the length of `arr` or $k$ is negative.
// If $k$ is 0, the function returns a list containing an empty tuple, representing the single combination of choosing nothing.
//
// -> array(array(any))
#let combinations(
	// The input array from which to choose elements.
	// The array can contain elements of any type.
	// -> array(any)
	arr, 
	// The number of elements to choose from the input array.
	// Must be a non-negative integer.
	// -> int
	k, 
	// Whether to allow repetition of elements in the combinations.
	// If #(true), elements can be chosen multiple times. If #(false), each element can be chosen only once.
	// Default is #(false).
	repetition: false,
) = {
	if repetition {
		return combinations-with-repetition(arr, k)
	} else {
		return combinations-no-repetition(arr, k)
	}
}
