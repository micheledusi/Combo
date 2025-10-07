#import "../src/lib.typ" as combo: *

// Let's assume you have a dataset of questions and answers
// The objective is to create a quiz with a subset of these questions
#let questions = (
	(
		question: "What is the capital of Italy?",
		answers: ("Rome", "Paris", "Venice", "Florence"),
		correct: "Rome",
	),
	(
		question: "What is the largest planet in our solar system?",
		answers: ("Earth", "Betelgeuse", "Jupiter", "Saturn"),
		correct: "Jupiter",
	),
	(
		question: "Who wrote 'The Tempest'?",
		answers: ("Ursula K. Le Guin", "Italo Calvino", "W. Shakespeare", "Douglas Adams"),
		correct: "W. Shakespeare",
	),
	(
		question: "How many roads must a man walk down?",
		answers: ("42", "7", "3", "5"),
		correct: "42",
	),
	(
		question: "How many different ways can you choose 3 items from a set of 5 distinct items?",
		answers: ("3", "10", "15", "30"),
		correct: "10",
	),
)

// It's easy to create differentiated versions of the same quiz by selecting different combinations of questions.
#for quiz-questions in combo.get-combinations(questions, 3) [
	// Here we have our 3-question test, we can build a template around it.
	#block(breakable: false, stroke: 1pt + gray, inset: 10pt, radius: 5pt)[

		= Quiz
		Answer the following questions:

		#for q in quiz-questions [
			+ *#q.question*
				#stack(dir: ltr,
					..q.answers.map(a => box(width: 25%)[
						▢ #a
					])
				)
				#v(1em)
		]

	]
]