//
//  QuizView.swift
//  Elements
//
//  Created by Adon Omeri on 8/11/2025.
//

import FoundationModels
import SwiftUI

struct QuizView: View {
	let elements: [Element]

	var model = SystemLanguageModel.default

	let session = LanguageModelSession(model: .init(useCase: .general, guardrails: .permissiveContentTransformations), instructions: """
		You are a chemistry teacher generating quizzes only about periodic table elements.

		# Difficulty rules
		difficulty: "easy" | "medium" | "hard"
		easy: using only elements 1–20 and only simpler properties of the element
		medium: use only elements 1–50 and can use somewhat common properties of the element
		hard: use any element and can use even complciated obscure properties of the element

		# Question design rules
		Every question must be about the provided element only (name, symbol, atomic number, group, period, classification like metal/nonmetal/metalloid, common uses, etc.).
		Use variety across the 10 questions (don’t repeat the same style).
		For easy/medium, mostly use multipleChoice.
		For hard, include more textField questions.

		# Multiple choice rules
		If format == "multipleChoice"
		options must contain exactly 4 choices
		only one option is correct
		correctAnswer must exactly match one of the 4 options

		# Text field rules
		If format == "textField":
		options must be nil
		correctAnswer must be the exact expected answer (for manual marking)
		""")

	@State var quiz: Quiz? = nil
	@State var difficulty: QuizDifficulty

	var main: some View {
		VStack {}
	}

	func generateQuiz() {
		let randomElement = difficulty.randomFilteredElement(elements: elements)

		let prompt = """
			Please make a quiz, with a difficulty of \(difficulty.rawValue). The random element is:
			\(randomElement)
			"""
	}

	var body: some View {
		VStack {
			switch model.availability {
				case .available:
					main
				case .unavailable(.deviceNotEligible):
					ContentUnavailableView("Device Not Elegible", systemImage: "apple.intelligence.badge.xmark", description: Text("This device can't use Apple Intelligence to create a quiz. Sorry."))
				case .unavailable(.appleIntelligenceNotEnabled):
					ContentUnavailableView("Apple Intelligence Not Enabled", systemImage: "apple.intelligence", description: Text("Please enable Apple Intelligence to make a quiz."))
				case .unavailable(.modelNotReady):
					ContentUnavailableView("Apple Intelligence Not Ready", systemImage: "apple.intelligence.badge.xmark", description: Text("Apple Intelligence is not ready at this moment. Please try again later."))
				case let .unavailable(other):
					ContentUnavailableView("Apple Intelligence Unavailable", systemImage: "apple.intelligence.badge.xmark", description: Text("Apple Intelligence is unavailable at this moment. Please try again later."))
			}
		}
		.toolbar {
			ToolbarItem(placement: .title) {
				Label("Quiz", systemImage: "questionmark.circle")
					.monospaced()
					.labelStyle(.titleAndIcon)
			}
		}
	}
}
