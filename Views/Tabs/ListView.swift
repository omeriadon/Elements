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
		GlassEffectContainer {
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
	}

	var filters: some View {
		VStack(alignment: .trailing, spacing: 8) {
			Group {
				Picker(selection: $selectedCategory) {
					Text("All").tag(nil as Category?)
					ForEach(Category.allCases, id: \.self) { category in
						Label(category.rawValue.capitalized, systemImage: category.symbol)
							.foregroundStyle(category.themeColor)
							.tag(category as Category?)
					}
				} label: {
					if selectedCategory == nil {
						Label("Category", systemImage: "line.3.horizontal.decrease.circle")
					}
				}
				.animation(.easeInOut, value: selectedCategory)

				Picker(selection: $selectedPhase) {
					Text("All").tag(nil as ElementPhase?)
					ForEach(ElementPhase.allCases, id: \.self) { phase in
						Label(phase.rawValue, systemImage: phase.symbol)
							.foregroundStyle(phase.colour)
							.tag(phase as ElementPhase?)
					}
				} label: {
					if selectedPhase == nil {
						Label("Phase", systemImage: "circle.dotted")
					}
				}
				.animation(.easeInOut, value: selectedPhase)

				Picker(selection: $selectedGroup) {
					Text("All").tag(nil as Int?)
					ForEach(1 ... 18, id: \.self) { group in
						Label("Group \(group)",
						      systemImage: group.description + ".circle")
							.foregroundStyle(colourForGroup(group))
							.tag(group as Int?)
					}
				} label: {
					if selectedGroup == nil {
						Label("Group", systemImage: "chevron.up.chevron.down")
					}
				}
				.animation(.easeInOut, value: selectedGroup)

				Picker(selection: $selectedPeriod) {
					Text("All").tag(nil as Int?)
					ForEach(1 ... 7, id: \.self) { period in
						Label(
							"Period \(period)",
							systemImage: period.description + ".square"
						)
						.foregroundStyle(colourForPeriod(period))
						.tag(period as Int?)
					}
				} label: {
					if selectedPeriod == nil {
						Label("Period", systemImage: "chevron.left.chevron.right")
					}
				}
				.animation(.easeInOut, value: selectedPeriod)

				Picker(selection: $selectedBlock) {
					Text("All").tag(nil as Block?)
					ForEach(Block.allCases, id: \.self) { block in
						Label(block.name.capitalized, systemImage: block.symbol)
							.foregroundStyle(block.colour)
							.tag(block as Block?)
					}
				} label: {
					if selectedBlock == nil {
						Label("Block", systemImage: "square.grid.2x2")
					}
				}
				.animation(.easeInOut, value: selectedBlock)
			}
			.pickerStyle(.navigationLink)
			.padding(10)
			.glassEffect(.regular.interactive())
			.fixedSize()
			.contentShape(Rectangle())
			.foregroundStyle(.primary)
		}
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
						.padding(.bottom, 60)
						.padding(.trailing)
				}
				.onChange(of: filteredElements) {
					if filteredElements.count == 1 {
						selectedElement = filteredElements.first
					}
				}
				.toolbar {
					ToolbarItem(placement: .title) {
						Text("List")
							.monospaced()
					}

					ToolbarItem(placement: .topBarTrailing) {
						if
							(selectedCategory != nil) ||
							(selectedPhase != nil) ||
							(selectedGroup != nil) ||
							(selectedPeriod != nil) ||
							(selectedBlock != nil)
						{
							Button {
								selectedCategory = nil
								selectedPhase = nil
								selectedGroup = nil
								selectedPeriod = nil
								selectedBlock = nil

							} label: {
								Label("Reset", systemImage: "arrow.circlepath")
							}
						}
					}
				}
				.sheet(item: $selectedElement) { element in
					ElementDetailView(element: element)
				}
		}
	}
}
