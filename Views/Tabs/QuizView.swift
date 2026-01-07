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

	var main: some View {
		Text("main")
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
