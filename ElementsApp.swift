//
//  ElementsApp.swift
//  Elements
//
//  Created by Adon Omeri on 7/11/2025.
//

import SwiftUI

@main
struct ElementsApp: App {
	let elements: [Element]? = loadElements()

	var body: some Scene {
		WindowGroup {
			if let elementsSafe = elements {
				ContentView(elements: elementsSafe)
			} else {
				ContentUnavailableView("Corrupted Data", systemImage: "exclamationmark.triangle.fill", description:
					Text("Please reinstall the app.")
						.foregroundStyle(.secondary))
					.foregroundStyle(.red)
			}
		}
	}
}
