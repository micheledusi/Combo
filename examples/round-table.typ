#import "../src/lib.typ" as combo: *
#import "@preview/cetz:0.4.2"


#let people = (
	"Alice",
	"Bob",
	"Charlie",
	"David",
	"Eve",
	"Frank",
)
#let n = people.len()

We have a round table and want to seat #n people around it. *How many different seating arrangements are possible?*

At first, we might think that the answer is simply the number of *permutations* of $#n$ people, which is $#n! = #combo.count-permutations(n, repetition: false)$.

However, since the table is round, we can rotate the seating arrangements without changing them. Thus, we need to divide by $#n$ to account for these rotations:
$ n! / n = (n - 1)! = #n!/#n = #(combo.count-permutations(n, repetition: false) / n) $

If we want to list all unique seating arrangements, we can *generate all permutations* and then *filter out those that are equivalent under rotation*. One way to do this is to select only the arrangements where a specific person (e.g. #people.at(0)) is in a fixed position (e.g., the first position).

However, there's a more efficient way to achieve this! We can still fix one person (e.g. #people.at(0)) in the first position and then generate permutations for the remaining $n - 1 =#(n - 1)$ people. This way, we directly get *all unique seating arrangements without needing to filter*.

#let placements = combo.get-permutations-no-repetition(people.slice(1)).map(p => (people.at(0),) + p)


// Function to visualize a seating arrangement
#let show-table(seating) = {
	cetz.canvas({
		import cetz.draw: *
		rect((-55pt, -35pt), (55pt, 38pt), fill: olive, stroke: none)

		// Draw table
		let r = 25pt
		circle((0, 0), radius: r, fill: rgb("#d6b18b"), stroke: rgb("#bfa080") + 3pt)

		// Draw people 
		let angle = 360deg / seating.len()
		scale(x: 1.4)
		for person in seating {
			content(
				(0, r),
				box(inset: 2pt, radius: 3pt, fill: white.transparentize(10%))[#person],
			)
			rotate(angle)
		}
	})
}

#grid(
	..placements.map(show-table), 
	columns: 4,
	gutter: 5pt,
)