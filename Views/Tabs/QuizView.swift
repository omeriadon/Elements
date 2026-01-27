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

    let session: LanguageModelSession = .init(
        model: .init(useCase: .general, guardrails: .permissiveContentTransformations),
        instructions: """
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
        """,
    )

    @State var quiz: Quiz.PartiallyGenerated? = nil
    @State var difficulty: QuizDifficulty = .easy
    @State var userAnswers: [Int: String] = [:]
    @State var gradingResults: [Int: Bool] = [:]
    @State var isGenerating = false
    @State var isGrading = false
    @State var isReviewing = false

    var allQuestionsAnswered: Bool {
        guard let questions = quiz?.questions else { return false }
        let count = questions.count
        if userAnswers.count != count { return false }
        return userAnswers.values.allSatisfy { !$0.isEmpty }
    }

    func resetQuiz() {
        withAnimation {
            quiz = nil
            userAnswers = [:]
            gradingResults = [:]
            isReviewing = false
        }
    }

    @ViewBuilder
    var main: some View {
        if let quiz, isGenerating == false {
            List {
                ActiveQuizView(
                    quiz: quiz,
                    userAnswers: $userAnswers,
                    gradingResults: gradingResults,
                    isReviewing: isReviewing,
                    isGrading: isGrading,
                    allQuestionsAnswered: allQuestionsAnswered,
                    submitQuiz: submitQuiz,
                    resetQuiz: resetQuiz,
                )
                Text("AI was used to create and mark these answers. It may not always be accurate.")
                    .font(.caption)
                    .listRowBackground(Color.clear)
            }
            .transition(.opacity)

        } else if isGenerating {
            VStack {
                QuizLoadingView()
                Spacer()
            }
            .transition(.opacity)

        } else {
            VStack {
                QuizSetupView(difficulty: $difficulty, generateQuiz: generateQuiz)
                Spacer()
            }
            .transition(.opacity)
        }
    }

    func generateQuiz() {
        withAnimation {
            isGenerating = true
            userAnswers = [:]
            gradingResults = [:]
            isGrading = false
        }

        let candidateElements = elements.filter { element in
            if difficulty == .easy {
                element.atomicNumber <= 20
            } else if difficulty == .medium {
                element.atomicNumber <= 50
            } else {
                true
            }
        }

        let selectedElements = candidateElements.shuffled().prefix(5)
        let elementListString = selectedElements.map { "\($0.name) (\($0.symbol))" }.joined(
            separator: ", ")

        let prompt = """
        Please make a quiz with 10 questions, with a difficulty of \(difficulty.rawValue).
        Use these specific elements for the questions: \(elementListString).

        IMPORTANT:
        - Mix the questions so they cover different elements from the list.
        - You must ONLY use facts and properties belonging to the specific element being asked about.
        - Do NOT use information about other elements.
        - Mention the element name in the question text so the user knows which one refers to.
        - Ensure specific data matches the provided element exactly.
        """

        print("Starting quiz generation with prompt: \(prompt)")

        Task {
            do {
                print("Creating stream response...")
                let stream = session.streamResponse(to: prompt, generating: Quiz.self)
                print("Stream created. Iterating...")

                var hasStarted = false
                for try await partial in stream {
                    if !hasStarted {
                        withAnimation {
                            isGenerating = false
                            hasStarted = true
                        }
                    }
                    print("Received partial update")
                    withAnimation {
                        quiz = partial.content
                    }
                }
                print("Quiz generation complete")
            } catch {
                print("Error generating quiz: \(error)")
                isGenerating = false
            }
        }
    }

    func submitQuiz() {
        guard let questions = quiz?.questions else { return }
        isGrading = true

        Task {
            for (index, question) in questions.enumerated() {
                guard let format = question.format, let correctAnswer = question.correctAnswer
                else { continue }
                let userAnswer = userAnswers[index] ?? ""

                if format == .multipleChoice {
                    gradingResults[index] = userAnswer == correctAnswer
                } else {
                    let gradePrompt = """
                    Question: \(question.question ?? "")
                    Correct Answer: \(correctAnswer)
                    User Answer: \(userAnswer)

                    Is the user answer effectively correct / close enough?
                    Think before answering.
                    """

                    do {
                        let response = try await session.respond(
                            to: gradePrompt, generating: Bool.self,
                        )
                        gradingResults[index] = response.content
                    } catch {
                        print("Grading error for Q\(index): \(error)")
                        // if the ai fails just check if two values are equal
                        gradingResults[index] =
                            userAnswer.lowercased().trimmingCharacters(in: .whitespaces)
                                == correctAnswer.lowercased().trimmingCharacters(in: .whitespaces)
                    }
                }
            }
            withAnimation {
                isGrading = false
                isReviewing = true
            }
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
                            "This device can't use Apple Intelligence to create a quiz. Sorry."),
                    )
                case .unavailable(.appleIntelligenceNotEnabled):
                    ContentUnavailableView(
                        "Apple Intelligence Not Enabled", systemImage: "apple.intelligence",
                        description: Text("Please enable Apple Intelligence to make a quiz."),
                    )
                case .unavailable(.modelNotReady):
                    ContentUnavailableView(
                        "Apple Intelligence Not Ready",
                        systemImage: "apple.intelligence.badge.xmark",
                        description: Text(
                            "Apple Intelligence is not ready at this moment. Please try again later.",
                        ),
                    )
                case .unavailable:
                    ContentUnavailableView(
                        "Apple Intelligence Unavailable",
                        systemImage: "apple.intelligence.badge.xmark",
                        description: Text(
                            "Apple Intelligence is unavailable at this moment. Please try again later.",
                        ),
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
                if quiz != nil, isGenerating == false {
                    Group {
                        if isReviewing {
                            Button(action: resetQuiz) {
                                Label("New Quiz", systemImage: "arrow.counterclockwise")
                            }
                        } else {
                            Button(action: submitQuiz) {
                                if isGrading {
                                    Label("Grading...", systemImage: "pencil.and.scribble")
                                } else {
                                    Text("Submit Answers")
                                }
                            }
                            .disabled(isGrading || !allQuestionsAnswered)
                        }
                    }
                    .buttonStyle(.glassProminent)
                    .controlSize(.extraLarge)
                    .padding(.bottom, 10)
                }
            }
        }
    }
}

private struct ActiveQuizView: View {
    let quiz: Quiz.PartiallyGenerated
    @Binding var userAnswers: [Int: String]
    let gradingResults: [Int: Bool]
    let isReviewing: Bool
    let isGrading: Bool
    let allQuestionsAnswered: Bool
    let submitQuiz: () -> Void
    let resetQuiz: () -> Void

    var body: some View {
        Group {
            if let questions = quiz.questions {
                ForEach(Array(questions.enumerated()), id: \.offset) { index, question in
                    QuizQuestionView(
                        index: index,
                        question: question,
                        userAnswers: $userAnswers,
                        gradingResults: gradingResults,
                        isReviewing: isReviewing,
                        isGrading: isGrading,
                    )
                    .transition(.blurReplace)
                }
            }
        }
        .navigationTitle(isReviewing ? "Review" : "Questions")
    }
}

private struct QuizQuestionView: View {
    let index: Int
    let question: QuizQuestion.PartiallyGenerated
    @Binding var userAnswers: [Int: String]
    let gradingResults: [Int: Bool]
    let isReviewing: Bool
    let isGrading: Bool

    var body: some View {
        Section {
            if let q = question.question {
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
                                    ? "checkmark.circle.fill" : "xmark.circle.fill",
                            )
                            .foregroundStyle(result ? .green : .red)
                            .font(.title2)
                        }
                    }
                    HStack {
                        Text(q)
                            .font(.title3.bold())
                        Spacer(minLength: 0)
                    }
                }
            }

            if let format = question.format {
                switch format {
                case .multipleChoice:
                    if let options = question.options {
                        VStack(spacing: 12) {
                            ForEach(options, id: \.self) { option in
                                let isSelected = userAnswers[index] == option
                                let isCorrect = question.correctAnswer == option
                                Button(action: {
                                    userAnswers[index] = option
                                }) {
                                    HStack {
                                        Text(option)
                                            .font(.body)
                                            .foregroundStyle(
                                                isSelected ? .white : .primary,
                                            )
                                            .frame(
                                                maxWidth: .infinity,
                                                alignment: .leading,
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
                    }
                case .textField:
                    TextField(
                        "Your Answer",
                        text: Binding(
                            get: { userAnswers[index] ?? "" },
                            set: { userAnswers[index] = $0 },
                        ),
                    )
                    .textFieldStyle(.plain)
                    .padding()
                    .background(.gray.opacity(0.2))
                    .cornerRadius(12)
                    .font(.body)
                    .disabled(isReviewing)
                }
            }

            if isReviewing || isGrading {
                if let correctAnswer = question.correctAnswer {
                    Text("Correct Answer: \(correctAnswer)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 100)
    }
}

private struct QuizSetupView: View {
    @Binding var difficulty: QuizDifficulty
    let generateQuiz: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            VStack(alignment: .leading) {
                Text("Difficulty")
                    .font(.caption)
                    .textCase(.uppercase)
                    .foregroundStyle(.secondary)

                Picker("Difficulty", selection: $difficulty) {
                    ForEach(QuizDifficulty.allCases) { diff in
                        Text(diff.rawValue.capitalized).tag(diff)
                    }
                }
                .pickerStyle(.segmented)
            }
            .frame(maxWidth: 300)

            Button(action: {
                generateQuiz()
            }) {
                Label("Generate Quiz", systemImage: "sparkles")
                    .font(.title3.bold())
                    .padding()
            }
            .buttonStyle(.glassProminent)
            .controlSize(.extraLarge)
        }
    }
}
