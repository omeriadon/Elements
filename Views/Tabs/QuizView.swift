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

	var model: SystemLanguageModel = .default

	@State var generatedQuestions: [QuizQuestion] = []
	@State var questionElements: [String] = []
	@State var difficulty: QuizDifficulty = .easy
	@State var userAnswers: [Int: String] = [:]
	@State var gradingResults: [Int: Bool] = [:]
	@State var isGenerating = false
	@State var isGrading = false
	@State var isReviewing = false
	@State var showScoreAlert = false
	@State var scoreAlert: ScoreAlert?

	var allQuestionsAnswered: Bool {
		if generatedQuestions.isEmpty { return false }
		let count = generatedQuestions.count
		if userAnswers.count != count { return false }
		return userAnswers.values.allSatisfy { !$0.isEmpty }
	}

	var score: Int {
		gradingResults.values.filter(\.self).count
	}

	func resetQuiz() {
		generatedQuestions = []
		questionElements = []
		userAnswers = [:]
		gradingResults = [:]
		isReviewing = false
	}

	@ViewBuilder
	var main: some View {
		if !generatedQuestions.isEmpty, isGenerating == false {
			List {
				ActiveQuizView(
					questions: generatedQuestions,
					userAnswers: $userAnswers,
					gradingResults: gradingResults,
					isReviewing: isReviewing,
					isGrading: isGrading,
					allQuestionsAnswered: allQuestionsAnswered,
					submitQuiz: submitQuiz,
					resetQuiz: resetQuiz
				)

				Text("AI was used to create and mark these answers. It may not always be accurate.")
					.font(.caption)
					.listRowBackground(Color.clear)
					.multilineTextAlignment(.center)
					.foregroundStyle(.secondary)
			}
			.listRowSeparator(.hidden)
			.transition(.blurReplace)

		} else if isGenerating {
			VStack {
				QuizLoadingView()
				Spacer()
			}
			.transition(.blurReplace)

		} else {
			VStack {
				QuizSetupView(difficulty: $difficulty, generateQuiz: generateQuiz)
				Spacer()
			}
			.transition(.blurReplace)
		}
	}

	func filteredElements() -> [Element] {
		switch difficulty {
			case .easy:
				elements.filter { $0.atomicNumber <= 20 }
			case .medium:
				elements.filter { $0.atomicNumber <= 50 }
			case .hard:
				elements
		}
	}

	func generateQuiz() {
		isGenerating = true
		userAnswers = [:]
		gradingResults = [:]
		isGrading = false

		Task {
			var questions: [QuizQuestion] = []
			var elementNames: [String] = []
			let candidates = filteredElements()
			let questionCount = 10

			for i in 0 ..< questionCount {
				guard let element = candidates.randomElement() else { continue }

				let useTextField = difficulty == .hard && i >= 7
				let format = useTextField ? "textField" : "multipleChoice"

				let instructions = if format == "multipleChoice" {
					"""
					You are a chemistry teacher. Generate ONE multiple choice question about \(element.name) (\(element.symbol), atomic number \(element.atomicNumber)).
					Difficulty: \(difficulty.rawValue).
					Rules:
					- format must be "multipleChoice"
					- Provide exactly 4 options
					- Each of those 4 options must be different - make sure of that, double check
					- Only ONE option must be correct
					- correctAnswer must exactly match one of the 4 options
					- Do NOT reveal the answer in the question text
					- Ask about: symbol, atomic number, group, period, classification (metal/nonmetal/metalloid), common uses, properties
					- Mention the element name in the question
					"""
				} else {
					"""
					You are a chemistry teacher. Generate ONE short-answer question about \(element.name) (\(element.symbol), atomic number \(element.atomicNumber)).
					Difficulty: \(difficulty.rawValue).
					Rules:
					- format must be "textField"
					- options must be empty array []
					- correctAnswer is the expected text answer (keep it short, 1-3 words)
					- Do NOT reveal the answer in the question text
					- Ask about: symbol, atomic number, group, period, classification, properties
					- Mention the element name in the question
					"""
				}

				do {
					let session = LanguageModelSession(
						model: .init(useCase: .general, guardrails: .permissiveContentTransformations),
						instructions: instructions
					)
					let response = try await session.respond(
						to: "Question about \(element.name)",
						generating: QuizQuestion.self
					)
					questions.append(response.content)
					elementNames.append(element.name)

					await MainActor.run {
						generatedQuestions = questions
						questionElements = elementNames
						if i == 0 {
							isGenerating = false
						}
					}
				} catch {
					continue
				}
			}

			await MainActor.run {
				isGenerating = false
			}
		}
	}

	func submitQuiz() {
		guard !generatedQuestions.isEmpty else { return }
		isGrading = true

		Task {
			for (index, question) in generatedQuestions.enumerated() {
				let correctAnswer = question.correctAnswer
				let userAnswer = userAnswers[index] ?? ""
				let elementName = index < questionElements.count ? questionElements[index] : "unknown element"

				do {
					let session = LanguageModelSession(
						model: .init(useCase: .contentTagging, guardrails: .permissiveContentTransformations),
						instructions: "You are grading a chemistry quiz about \(elementName). Double check your marking, don't mark everything correct or wrong just because you want to."
					)
					let response = try await session.respond(
						to: "Question: \(question.question)\nCorrect answer: \(correctAnswer)\nUser answer: \(userAnswer)\nIs the user's answer correct?",
						generating: Bool.self
					)
					gradingResults[index] = response.content
				} catch {
					gradingResults[index] =
						userAnswer.lowercased().trimmingCharacters(in: .whitespaces)
							== correctAnswer.lowercased().trimmingCharacters(in: .whitespaces)
				}
			}

			let finalScore = gradingResults.values.filter(\.self).count
			let total = generatedQuestions.count

			do {
				let session = LanguageModelSession(
					model: .init(useCase: .general, guardrails: .permissiveContentTransformations),
					instructions: """
					Generate a short alert for a quiz score. Include the score in the message.
					Match the tone to the score:
					- 0-3: sympathetic, encouraging to try again
					- 4-6: okay effort, room for improvement
					- 7-8: good job, almost there
					- 9-10: celebrate, excellent work
					Keep it brief and natural, not over the top.
					"""
				)
				let response = try await session.respond(
					to: "Score: \(finalScore)/\(total), Difficulty: \(difficulty.rawValue)",
					generating: ScoreAlert.self
				)
				await MainActor.run {
					scoreAlert = response.content
				}
			} catch {
				await MainActor.run {
					scoreAlert = ScoreAlert(
						title: "Quiz Complete!",
						message: "You scored \(finalScore)/\(total)",
						buttonText: "OK"
					)
				}
			}

			isGrading = false
			isReviewing = true
			showScoreAlert = true
		}
	}

	var body: some View {
		NavigationStack {
			VStack {
				switch model.availability {
					case .available:
						main
					case .unavailable(.deviceNotEligible):
						ContentUnavailableView(
							"Device Not Elegible", systemImage: "apple.intelligence.badge.xmark",
							description: Text(
								"This device can't use Apple Intelligence to create a quiz. Sorry.")
						)
					case .unavailable(.appleIntelligenceNotEnabled):
						ContentUnavailableView(
							"Apple Intelligence Not Enabled", systemImage: "apple.intelligence",
							description: Text("Please enable Apple Intelligence to make a quiz.")
						)
					case .unavailable(.modelNotReady):
						ContentUnavailableView(
							"Apple Intelligence Not Ready",
							systemImage: "apple.intelligence.badge.xmark",
							description: Text(
								"Apple Intelligence is not ready at this moment. Please try again later."
							)
						)
					case .unavailable:
						ContentUnavailableView(
							"Apple Intelligence Unavailable",
							systemImage: "apple.intelligence.badge.xmark",
							description: Text(
								"Apple Intelligence is unavailable at this moment. Please try again later."
							)
						)
				}
			}
			.toolbar {
				ToolbarItem(placement: .title) {
					Label("Quiz", systemImage: "questionmark.circle")
						.monospaced()
						.labelStyle(.titleAndIcon)
				}
			}
			.safeAreaBar(edge: .bottom, alignment: .center) {
				if !generatedQuestions.isEmpty, isGenerating == false {
					Group {
						if isReviewing {
							Button(action: resetQuiz) {
								Label("New Quiz", systemImage: "arrow.counterclockwise")
							}
							.transition(.blurReplace)
						} else {
							Button(action: submitQuiz) {
								Group {
									if isGrading {
										Label("Grading...", systemImage: "pencil.and.scribble")
											.transition(.blurReplace)
									} else {
										Label("Submit Answers", systemImage: "checkmark")
											.transition(.blurReplace)
									}
								}
								.animation(.easeInOut, value: isGrading)
							}
							.disabled(isGrading || !allQuestionsAnswered)
							.transition(.blurReplace)
						}
					}
					.buttonStyle(.glassProminent)
					.controlSize(.extraLarge)
					.padding(.bottom, 10)
					.animation(.easeInOut, value: "\(isReviewing)\(isGrading)")
				}
			}
			.alert(
				scoreAlert?.title ?? "Quiz Complete!",
				isPresented: $showScoreAlert
			) {
				Button(scoreAlert?.buttonText ?? "OK") {}
			} message: {
				Text(scoreAlert?.message ?? "You scored \(score)/\(generatedQuestions.count)")
			}
		}
	}
}

private struct ActiveQuizView: View {
	let questions: [QuizQuestion]
	@Binding var userAnswers: [Int: String]
	let gradingResults: [Int: Bool]
	let isReviewing: Bool
	let isGrading: Bool
	let allQuestionsAnswered: Bool
	let submitQuiz: () -> Void
	let resetQuiz: () -> Void

	var body: some View {
		Group {
			ForEach(Array(questions.enumerated()), id: \.offset) { index, question in
				QuizQuestionView(
					index: index,
					question: question,
					userAnswers: $userAnswers,
					gradingResults: gradingResults,
					isReviewing: isReviewing,
					isGrading: isGrading
				)
				.transition(.blurReplace)
			}
		}
		.animation(.easeInOut, value: questions.count)
	}
}

private struct QuizQuestionView: View {
	let index: Int
	let question: QuizQuestion
	@Binding var userAnswers: [Int: String]
	let gradingResults: [Int: Bool]
	let isReviewing: Bool
	let isGrading: Bool

	var body: some View {
		Section {
			VStack {
				HStack {
					Text("\(index + 1)")
						.foregroundStyle(.secondary)
						.font(.title3)
						.fontDesign(.monospaced)

					Spacer()

					if isReviewing || isGrading,
					   let result = gradingResults[index]
					{
						Image(
							systemName: result
								? "checkmark.circle.fill" : "xmark.circle.fill"
						)
						.foregroundStyle(result ? .green : .red)
						.font(.title2)
					}
				}
				HStack {
					Text(question.question)
						.font(.title3.bold())
					Spacer(minLength: 0)
				}
			}

			switch question.format {
				case .multipleChoice:
					VStack(spacing: 12) {
						ForEach(question.options, id: \.self) { option in
							let isSelected = userAnswers[index] == option
							let isCorrect = question.correctAnswer == option
							Button(action: {
								userAnswers[index] = option
							}) {
								HStack {
									Text(option)
										.font(.body)
										.foregroundStyle(
											isSelected ? .white : .primary
										)
										.frame(
											maxWidth: .infinity,
											alignment: .leading
										)

									Image(systemName: "circle.fill")
										.foregroundStyle(.white)
										.opacity(isSelected ? 1 : 0)
								}
								.padding()
								.background {
									if isReviewing {
										if isCorrect {
											Color.green
										} else if isSelected, !isCorrect {
											Color.red
										} else {
											Color.gray.opacity(0.2)
										}
									} else {
										isSelected
											? Color.accentColor
											: Color.gray.opacity(0.2)
									}
								}
								.cornerRadius(12)
							}
							.buttonStyle(.plain)
							.disabled(isReviewing)
						}
					}
				case .textField:
					TextField(
						"Your Answer",
						text: Binding(
							get: { userAnswers[index] ?? "" },
							set: { userAnswers[index] = $0 }
						)
					)
					.textFieldStyle(.plain)
					.padding()
					.background(.gray.opacity(0.2))
					.cornerRadius(12)
					.font(.body)
					.disabled(isReviewing)
			}

			if isReviewing || isGrading {
				Text("Correct Answer: \(question.correctAnswer)")
					.font(.caption)
					.foregroundStyle(.secondary)
					.transition(.opacity)
			}
		}
	}
}

private struct QuizLoadingView: View {
	var body: some View {
		VStack(spacing: 20) {
			ProgressView()
				.controlSize(.extraLarge)
			Text("Designing your quiz...")
				.font(.headline)
				.foregroundStyle(.secondary)
		}
	}
}

private struct QuizSetupView: View {
	@Binding var difficulty: QuizDifficulty
	let generateQuiz: () -> Void

	var body: some View {
		VStack(spacing: 32) {
			VStack(alignment: .leading) {
				Text("Difficulty")
					.textCase(.uppercase)
					.foregroundStyle(.secondary)

				Picker("Difficulty", selection: $difficulty) {
					ForEach(QuizDifficulty.allCases) { diff in
						Text(diff.rawValue.capitalized)
							.padding(.horizontal)
							.tag(diff)
					}
				}
				.pickerStyle(.segmented)
				.controlSize(.extraLarge)
			}

			Button {
				generateQuiz()
			} label: {
				Label("Generate Quiz", systemImage: "sparkles")
					.font(.title3.bold())
					.padding(.horizontal)
					.padding(.vertical, 12)
			}
			.buttonStyle(.glassProminent)
		}
		.padding(.horizontal, 20)
	}
}
