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
					element.series.rawValue.localizedCaseInsensitiveContains(searchText) ||
					element.atomicNumber.description.contains(searchText)
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
					placement: .navigationBarDrawer,
					prompt: "Search names, series, numbers, and more"
				)
				.safeAreaBar(edge: .top, alignment: .leading) {
					HStack(spacing: 15) {
						
					}
					.padding()
				}
				.onChange(of: filteredElements) { _, _ in
					if filteredElements.count == 1 {
						selectedElement = filteredElements.first
					}
				}
				.toolbar {
					ToolbarItem(placement: .title) {
						Text("List")
							.monospaced()
					}
				}
				.sheet(item: $selectedElement) { element in
					ElementDetailView(element: element)
				}
		}
	}
}
