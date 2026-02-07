//
//  ContentView.swift
//  Elements
//
//  Created by Adon Omeri on 7/11/2025.
//

import SwiftUI

struct ContentView: View {
	let elements: [Element]

	var tabs: [AppTabItem] {
		[
			AppTabItem(
				name: "Table",
				symbol: "atom",
				view: AnyView(TableView(elements: elements))
			),
			AppTabItem(
				name: "Quiz",
				symbol: "questionmark.circle",
				view: AnyView(QuizView(elements: elements))
			),
			AppTabItem(
				name: "Settings",
				symbol: "gear",
				view: AnyView(SettingsView(elements: elements))
			),
		]
	}

	@State var selectedTab = "Table"

	var body: some View {
		TabView(selection: $selectedTab) {
			ForEach(tabs) { tab in
				Tab(value: tab.id) {
					tab.view
				} label: {
					Label(tab.name, systemImage: tab.symbol)
				}
			}

			Tab(value: "Search", role: .search) {
				ListView(elements: elements)
			}
		}
		.tabBarMinimizeBehavior(.onScrollDown)
		.onChange(of: selectedTab) {
			HapticManager.shared.impact()
		}
	}
}

struct AppTabItem: Identifiable {
	var id: String {
		name
	}

	let name: String
	let symbol: String
	let view: AnyView
}
