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
			name: "Quiz",
			symbol: "questionmark.circle",
			view: AnyView(QuizView(elements: elements))
		),
		TabItem(
			name: "Help",
			symbol: "info.circle",
			view: AnyView(Text("help here"))
		),
		TabItem(
			name: "Settings",
			symbol: "gear",
			view: AnyView(Text("settings here"))
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

			Tab(role: .search) {
				ListView(elements: elements)
			}
		}
		.tabBarMinimizeBehavior(.onScrollDown)
	}
}

struct TabItem {
	let name: String
	let symbol: String
	let view: AnyView
}
