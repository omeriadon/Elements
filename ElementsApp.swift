//
//  ElementsApp.swift
//  Elements
//
//  Created by Adon Omeri on 7/11/2025.
//

import SwiftData
import SwiftUI
import TipKit

@main
struct ElementsApp: App {
	let elements: [Element]? = loadElements()

	@AppStorage("appHasOpenedBefore") var appHasOpenedBefore: Bool = false

	var showSheet: Bool {
		!appHasOpenedBefore
	}

	init() {
		setupTips()
	}

	func setupTips() {
		do {
			#if DEBUG
				// done testing tips for now
//				try Tips.resetDatastore()
			#endif

			try Tips.configure()
		} catch {
			print("Error initializing TipKit \(error.localizedDescription)")
		}
	}

	var body: some Scene {
		WindowGroup {
			if let elementsSafe = elements {
				ContentView(elements: elementsSafe)
					.sheet(isPresented: .constant(showSheet)) {
						IntroView(appHasOpenedBefore: Binding(
							get: {
								appHasOpenedBefore
							},
							set: {
								appHasOpenedBefore = $0
							}
						))
						.interactiveDismissDisabled()
						.presentationDragIndicator(.hidden)
					}
			} else {
				ContentUnavailableView("Corrupted Data", systemImage: "exclamationmark.triangle.fill", description:
					Text("Please reinstall the app.")
						.foregroundStyle(.secondary))
					.foregroundStyle(.red)
			}
		}
		.modelContainer(for: Bookmark.self)
	}
}
