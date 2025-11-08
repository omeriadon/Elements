//
//  ElementsApp.swift
//  Elements
//
//  Created by Adon Omeri on 7/11/2025.
//

import SwiftUI
import Portal

@main
struct ElementsApp: App {

	let elements: [Element] = loadElements()

	var body: some Scene {
		WindowGroup {
			PortalContainer {
				ContentView(elements: elements)
			}
		}
	}
}
