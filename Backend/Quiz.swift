//
//  QuizQuestion.swift
//  Elements
//
//  Created by Adon Omeri on 7/11/2025.
//

import Foundation
import FoundationModels

@Generable
struct QuizQuestion: Identifiable {
	let id = UUID()

	@Guide(description: "The question, in sentence question case.")
	let question: String

	@Guide(description: "the right answer")
	let correctAnswer: String

	@Guide(description: "the options, only one is correct, make it nil if its a textfield instead of multichoice.")
	@Guide(.count(4))
	let options: [String]?

	let type: QuizType

	let format: QuizFormat

	@Guide(description: "easy for first 20 elements, medium for first 50 elements only, hard for all elements.")
	let difficulty: Difficulty

	let element: Element
}

@Generable
enum QuizType: String {
	case symbolToName, nameToSymbol
}

@Generable
enum QuizFormat: String {
	case multipleChoice, textField
}

@Generable
enum Difficulty: String {
	case easy // first 20 elements
	case medium // first 50 elements
	case hard // all
}
