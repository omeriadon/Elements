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

	@State var selectedCategory: Category?
	@State var selectedPhase: ElementPhase?
	@State var selectedGroup: Int?
	@State var selectedPeriod: Int?
	@State var selectedBlock: Block?

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

		if let category = selectedCategory {
			result = result.filter { $0.series == category }
		}

		if let phase = selectedPhase {
			result = result.filter { $0.phase == phase }
		}

		if let group = selectedGroup {
			result = result.filter { $0.group == group }
		}

		if let period = selectedPeriod {
			result = result.filter { $0.period == period }
		}

		if let block = selectedBlock {
			result = result.filter { $0.block == block }
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
						.background(.ultraThickMaterial)
						.clipShape(Capsule())
					}
					.buttonStyle(.plain)
					.transition(.blurReplace)
				}
			}
			.animation(.spring(response: 0.35, dampingFraction: 0.8), value: filteredElements)
			.padding(.horizontal)
		}
	}

	var filters: some View {
		ScrollView(.horizontal) {
			HStack(spacing: 12) {
				Menu {
					Button("All") { selectedCategory = nil }
					ForEach(Category.allCases, id: \.self) { category in
						Button {
							selectedCategory = category
						} label: {
							Label(category.rawValue.capitalized, systemImage: categorySymbol(category))
								.tint(category.themeColor)
						}
					}
				} label: {
					HStack(spacing: 6) {
						if let category = selectedCategory {
							Image(systemName: categorySymbol(category))
							Text(category.rawValue.capitalized)
						} else {
							Image(systemName: "line.3.horizontal.decrease.circle")
							Text("Category")
						}
					}

					.padding(.horizontal, 12)
					.padding(.vertical, 8)
					.glassEffect(.clear.tint(selectedCategory?.themeColor ?? nil))
				}

				Menu {
					Button("All") { selectedPhase = nil }
					ForEach(ElementPhase.allCases, id: \.self) { phase in
						Button {
							selectedPhase = phase
						} label: {
							Label(phase.rawValue, systemImage: phase.symbol)
								.tint(phaseColor(phase))
						}
					}
				} label: {
					HStack(spacing: 6) {
						if let phase = selectedPhase {
							Image(systemName: phase.symbol)
							Text(phase.rawValue)
						} else {
							Image(systemName: "circle.dotted")
							Text("Phase")
						}
					}

					.padding(.horizontal, 12)
					.padding(.vertical, 8)
					.glassEffect(.clear.tint(selectedPhase != nil ? phaseColor(selectedPhase!) : nil))
				}

				Menu {
					Button("All") { selectedGroup = nil }
					ForEach(1 ... 18, id: \.self) { group in
						Button {
							selectedGroup = group
						} label: {
							Label(
								group.description,
								systemImage: group.description + ".circle"
							)
							.tint(colourForGroup(group))
						}
					}
				} label: {
					HStack(spacing: 6) {
						Image(systemName: "chevron.up.chevron.down")
						if let group = selectedGroup {
							Text("Group \(group)")
						} else {
							Text("Group")
						}
					}

					.padding(.horizontal, 12)
					.padding(.vertical, 8)
					.glassEffect(.clear.tint(selectedGroup != nil ? colourForGroup(selectedGroup!) : nil))
				}

				Menu {
					Button("All") { selectedPeriod = nil }
					ForEach(1 ... 7, id: \.self) { period in
						Button {
							selectedPeriod = period
						} label: {
							Label(
								period.description,
								systemImage: period.description + ".circle"
							)
							.tint(colourForPeriod(period))
						}
					}
				} label: {
					HStack(spacing: 6) {
						Image(systemName: "chevron.left.chevron.right")
						if let period = selectedPeriod {
							Text("Period \(period)")
						} else {
							Text("Period")
						}
					}

					.padding(.horizontal, 12)
					.padding(.vertical, 8)
					.glassEffect(.clear.tint(selectedPeriod != nil ? colourForPeriod(selectedPeriod!) : nil))
				}

				Menu {
					Button("All") { selectedBlock = nil }
					ForEach(Block.allCases, id: \.self) { block in
						Button {
							selectedBlock = block
						} label: {
							Label(block.name.capitalized, systemImage: blockSymbol(block))
								.tint(blockColor(block))
						}
					}
				} label: {
					HStack(spacing: 6) {
						if let block = selectedBlock {
							Image(systemName: blockSymbol(block))
							Text(block.name.capitalized)
						} else {
							Image(systemName: "square.grid.2x2")
							Text("Block")
						}
					}

					.padding(.horizontal, 12)
					.padding(.vertical, 8)
					.glassEffect(.clear.tint(selectedBlock != nil ? blockColor(selectedBlock!) : nil))
				}
			}
		}
		.padding(.leading)
		.scrollIndicators(.hidden)
		.frame(height: 25)
		.foregroundStyle(.primary)
	}

	var body: some View {
		NavigationStack {
			main
				.searchable(
					text: $searchText,
					prompt: "Search names, series, numbers, and more"
				)
				.safeAreaBar(edge: .bottom) {
					filters
						.padding(.bottom)
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

	func categorySymbol(_ category: Category) -> String {
		switch category {
		case .alkalineEarthMetal: "leaf"
		case .metalloid: "triangle.lefthalf.filled"
		case .nonmetal: "leaf.arrow.triangle.circlepath"
		case .nobleGas: "seal"
		case .alkaliMetal: "flame"
		case .postTransitionMetal: "cube"
		case .transitionMetal: "gearshape"
		case .lanthanide: "sun.min"
		case .actinide: "atom"
		}
	}

	func phaseColor(_ phase: ElementPhase) -> Color {
		switch phase {
		case .solid: Color(red: 0.8, green: 0.8, blue: 0.8)
		case .liquid: Color(red: 0.6, green: 0.8, blue: 1.0)
		case .gas: Color(red: 1.0, green: 1.0, blue: 0.7)
		}
	}

	func blockSymbol(_ block: Block) -> String {
		switch block {
		case .sBlock: "s.square"
		case .pBlock: "p.square"
		case .dBlock: "d.square"
		case .fBlock: "f.square"
		}
	}

	func blockColor(_ block: Block) -> Color {
		switch block {
		case .sBlock: Color(red: 1.0, green: 0.8, blue: 0.6)
		case .pBlock: Color(red: 0.7, green: 0.9, blue: 0.7)
		case .dBlock: Color(red: 0.6, green: 0.8, blue: 1.0)
		case .fBlock: Color(red: 1.0, green: 0.75, blue: 0.5)
		}
	}
}
