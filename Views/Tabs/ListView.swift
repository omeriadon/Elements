//
//  ListView.swift
//  Elements
//
//  Created by Adon Omeri on 8/11/2025.
//

import SwiftData
import SwiftUI

struct ListView: View {
	@Environment(\.modelContext) var modelContext

	@State private var storage: Storage?

	let elements: [Element]

	@State var selectedElement: Element? = nil

	@State var searchText = ""

	@State var tokens: [ElementToken] = []

	var filteredElements: [Element] {
		var result = elements

		if !searchText.isEmpty {
			result = result.filter { element in
				element.name.localizedCaseInsensitiveContains(searchText) ||
					element.symbol.localizedCaseInsensitiveContains(searchText) ||
					element.atomicNumber.description.contains(searchText) ||
					element.series.rawValue.localizedCaseInsensitiveContains(searchText)
			}
		}

		if !tokens.isEmpty {
			for token in tokens {
				switch token {
				case let .category(category):
					result = result.filter { $0.series == category }
				case let .phase(phase):
					result = result.filter { $0.phase == phase }
				case let .group(group):
					result = result.filter { $0.group == group }
				case let .period(period):
					result = result.filter { $0.period == period }
				case let .block(block):
					result = result.filter { $0.block == block }
				}
			}
		}

		return result
	}

	var main: some View {
		ScrollView {
			LazyVStack(spacing: 8) {
				ForEach(filteredElements) { element in
					Button {
						selectedElement = element
					} label: {
						HStack {
							Text(element.symbol)
								.font(.title2)
								.foregroundStyle(element.series.themeColor)
								.fontDesign(.monospaced)
								.bold()
								.padding(.trailing)
							Text(element.atomicNumber.description)
								.foregroundStyle(.tertiary)
								.fontDesign(.monospaced)
							Spacer()
							Text(element.name)
								.font(.title3)
						}
						.padding()
						.background(.ultraThinMaterial)
						.clipShape(RoundedRectangle(cornerRadius: 25))
					}
					.buttonStyle(.plain)
					.transition(.blurReplace)
				}
			}
			.animation(.spring(response: 0.35, dampingFraction: 0.8), value: filteredElements)
			.padding(.horizontal)
		}
	}

	var body: some View {
		NavigationStack {
			main
				.searchable(
					text: $searchText,
					tokens: $tokens,
					suggestedTokens:
					Binding(
						get: {
							allTokens()
						},
						set: { _ in }
					),
					prompt: "Search names, series, numbers, and more"
				) { token in
					LeftRight {
						Text(token.label)
					} right: {
						Image(systemName: token.symbol)
					}
					.foregroundStyle(token.color)
				}
				.onSubmit(of: .search) {
					addRecentSearch(searchText)
				}
				.searchSuggestions {
					if let recentSearches = storage?.recentSearches {
						ForEach(recentSearches, id: \.self) { search in
							Text(search).searchCompletion(search)
						}
					}
				}
				.onChange(of: filteredElements) { _, _ in
					if filteredElements.count == 1 {
						selectedElement = filteredElements.first
					}
				}
				.toolbar {
					ToolbarItem(placement: .primaryAction) {
						Button {} label: {
							Label("Sort", systemImage: "arrow.up.arrow.down")
						}
					}
					ToolbarItem(placement: .title) {
						Text("List")
							.monospaced()
					}
				}
				.sheet(item: $selectedElement) { element in
					ElementDetailView(element: element)
				}
		}
		.task {
			await loadStorage()
		}
	}

	func suggestedTokensForSearchText(_ text: String) -> [ElementToken] {
		guard !text.isEmpty else { return [] }

		let lower = text.lowercased()

		return allTokens().filter { token in
			token.label.lowercased().contains(lower)
		}
	}

	@MainActor
	func loadStorage() async {
		let request = FetchDescriptor<Storage>()
		if let data = try? modelContext.fetch(request),
		   let existing = data.first
		{
			storage = existing
		} else {
			let newStorage = Storage(recentSearches: ["Hydrogen", "Oxygen"])
			modelContext.insert(newStorage)
			try? modelContext.save()
			storage = newStorage
		}
	}

	func addRecentSearch(_ element: String) {
		guard let storage else { return }
		storage.recentSearches.append(element)
		try? modelContext.save()
	}
}
