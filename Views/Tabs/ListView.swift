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
		GlassEffectContainer {
			VStack(alignment: .trailing, spacing: 8) {
				Group {
					Picker(selection: $selectedCategory) {
						Text("All").tag(nil as Category?)
						ForEach(Category.allCases, id: \.self) { category in
							Label(category.rawValue.capitalized, systemImage: categorySymbol(category))
								.foregroundStyle(category.themeColor)
								.tag(category as Category?)
						}
					} label: {
						Label(
							selectedCategory?.rawValue.capitalized ?? "Category",
							systemImage: selectedCategory.map { categorySymbol($0) } ?? "line.3.horizontal.decrease.circle"
						)
					}
					.padding(10)
					.glassEffect(
						.regular.tint(selectedCategory?.themeColor).interactive()
					)

					Picker(selection: $selectedPhase) {
						Text("All").tag(nil as ElementPhase?)
						ForEach(ElementPhase.allCases, id: \.self) { phase in
							Label(phase.rawValue, systemImage: phase.symbol)
								.foregroundStyle(phaseColor(phase))
								.tag(phase as ElementPhase?)
						}
					} label: {
						Label(
							selectedPhase?.rawValue ?? "Phase",
							systemImage: selectedPhase?.symbol ?? "circle.dotted"
						)
					}
					.padding(10).glassEffect(.regular.tint(selectedPhase.map { phaseColor($0) }).interactive())

					Picker(selection: $selectedGroup) {
						Text("All").tag(nil as Int?)
						ForEach(1 ... 18, id: \.self) { group in
							Text("Group \(group)")
								.foregroundStyle(colourForGroup(group))
								.tag(group as Int?)
						}
					} label: {
						Label(
							selectedGroup.map { "Group \($0)" } ?? "Group",
							systemImage: "chevron.up.chevron.down"
						)
					}
					.padding(10).glassEffect(.regular.tint(selectedGroup.map { colourForGroup($0) }).interactive())

					Picker(selection: $selectedPeriod) {
						Text("All").tag(nil as Int?)
						ForEach(1 ... 7, id: \.self) { period in
							Text("Period \(period)")
								.foregroundStyle(colourForPeriod(period))
								.tag(period as Int?)
						}
					} label: {
						Label(
							selectedPeriod.map { "Period \($0)" } ?? "Period",
							systemImage: "chevron.left.chevron.right"
						)
						.padding(10)
						.glassEffect(.regular.tint(selectedPeriod.map { colourForPeriod($0) }).interactive())
					}

					Picker(selection: $selectedBlock) {
						Text("All").tag(nil as Block?)
						ForEach(Block.allCases, id: \.self) { block in
							Label(block.name.capitalized, systemImage: blockSymbol(block))
								.foregroundStyle(blockColor(block))
								.tag(block as Block?)
						}
					} label: {
						Label(
							selectedBlock?.name.capitalized ?? "Block",
							systemImage: selectedBlock.map { blockSymbol($0) } ?? "square.grid.2x2"
						)
						.padding(10)
						.glassEffect(.regular.tint(selectedBlock.map { blockColor($0) }).interactive())
					}
				}
				.pickerStyle(.navigationLink)
				.fixedSize()
			}
		}
		.foregroundStyle(.primary)
	}

	var body: some View {
		NavigationStack {
			main
				.searchable(
					text: $searchText,
					prompt: "Search names, series, numbers, and more"
				)
				.overlay(alignment: .bottomTrailing) {
					filters
						.padding(.bottom)
						.padding(.trailing)
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
		case .solid: .brown
		case .liquid: .blue
		case .gas: .yellow
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
