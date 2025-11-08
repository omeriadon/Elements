//
//  QuizQuestion.swift
//  Elements
//
//  Created by Adon Omeri on 7/11/2025.
//

import Foundation

struct QuizQuestion: Identifiable {
	let id = UUID()
	let question: String
	let correctAnswer: String
	let options: [String]? // nil for textfield type
	let type: QuizType
	let format: QuizFormat
	let difficulty: Difficulty
	let element: Element
}

enum QuizType: String, Codable {
	case symbolToName, nameToSymbol
}

enum QuizFormat: String, Codable {
	case multipleChoice, textField
}	

enum Difficulty: String, Codable {
	case easy, medium, hard
}

enum FilterType: String, Codable {
	case elementType, stateAt25C, group, period
}
