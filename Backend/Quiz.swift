//
//  Quiz.swift
//  Elements
//
//  Created by Adon Omeri on 7/11/2025.
//

import Foundation
import FoundationModels

@Generable
struct Quiz {
	let questions: [QuizQuestion]
}

@Generable
struct QuizQuestion: Identifiable {
	let id = UUID()
	let format: QuizFormat

	@Guide(description: "DO NOT PUT THE OPTIONS HERE")
	let question: String

	let correctAnswer: String
	@Guide(.count(4))
	let options: [String]
}

@Generable
enum QuizFormat: String {
	case multipleChoice, textField
}

enum QuizDifficulty: String, CaseIterable, Identifiable {
	var id: Self { self }
	case easy
	case medium
	case hard
}

@Generable
struct ScoreAlert {
	let title: String
	let message: String
	let buttonText: String
}
