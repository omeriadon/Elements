//
//  ContentView.swift
//  Elements
//
//  Created by Adon Omeri on 7/11/2025.
//

import SwiftUI

struct ContentView: View {
	let elements: [Element]

	var tabs: [TabItem] { [
		TabItem(
			name: "Table",
			symbol: "atom",
			view: AnyView(TableView(elements: elements))
		),
		TabItem(
			name: "List",
			symbol: "list.bullet",
			view: AnyView(ListView(elements: elements))
		),
		TabItem(
			name: "Quiz",
			symbol: "questionmark.app",
			view: AnyView(QuizView(elements: elements))
		),
	] }

	var body: some View {
		TabView {
			ForEach(tabs, id: \.name) { tab in
				Tab {
					tab.view
				} label: {
					Label(tab.name, systemImage: tab.symbol)
				}
			}
		}
	}
}

struct TabItem {
	let name: String
	let symbol: String
	let view: AnyView
}

#Preview {
	ContentView(elements: loadElements())
}
