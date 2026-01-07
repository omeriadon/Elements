//
//  QuizQuestion.swift
//  Elements
//
//  Created by Adon Omeri on 7/11/2025.
//

import Foundation
import FoundationModels

@Generable
struct Quiz {
	@Guide(.count(10))
	let questions: [QuizQuestion]
}

@Generable
struct QuizQuestion: Identifiable {
	let id = UUID()

	let format: QuizFormat

	@Guide(description: "The question, in sentence question case.")
	let question: String

	@Guide(description: "the right answer")
	let correctAnswer: String

	@Guide(description: "the options, only one is correct, make it nil if its a textfield instead of multichoice.")
	@Guide(.count(4))
	let options: [String]?
}

@Generable
enum QuizFormat: String {
	case multipleChoice, textField
}

enum QuizDifficulty: String, CaseIterable, Identifiable {
	var id: Self { self }
	case easy // first 20 elements
	case medium // first 50 elements
	case hard // all

	func randomFilteredElement(elements: [Element]) -> Element {
		var filteredElements: [Element] = []

		switch self {
			case .easy:
				filteredElements = elements.filter { $0.atomicNumber <= 20 }
			case .medium:
				filteredElements = elements.filter { $0.atomicNumber <= 50 }
			case .hard:
				filteredElements = elements
		}

		return filteredElements.randomElement() ?? elements.first!
	}
}
