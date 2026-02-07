//
//  ListView.swift
//  Elements
//
//  Created by Adon Omeri on 8/11/2025.
//

import SwiftData
import SwiftUI
import TipKit

let filterTip = FilterTip()
let sortTip = SortTip()

struct ListView: View {
	@Environment(\.modelContext) var modelContext
	@Environment(\.colorScheme) var colorScheme
	@Environment(\.accessibilityReduceMotion) var reduceMotion

	@Query private var bookmarks: [Bookmark]

	let elements: [Element]

	@State var selectedElement: Element? = nil
	@State var searchText = ""

	@State var selectedCategory: Category?
	@State var selectedPhase: ElementPhase?
	@State var selectedGroup: Int?
	@State var selectedPeriod: Int?
	@State var selectedBlock: Block?

	@State var sortBy: SortOption = .atomicNumber
	@State var sortAscending = true

	@State private var keyboardVisible = false
	@Namespace var namespace

	@State private var tipGroup: TipGroup

	enum BookmarkFilter: String, CaseIterable, Identifiable {
		case onlyBookmarked = "Only Bookmarked"
		case bookmarkedTop = "Bookmarked at Top"
		case all = "All"
		var id: String {
			rawValue
		}
	}

	@State private var bookmarkFilter: BookmarkFilter = .all

	init(elements: [Element]) {
		self.elements = elements
		_tipGroup = State(initialValue: TipGroup(.firstAvailable) {
			filterTip
			sortTip
		})
	}

	var oppositeForegroundStyle: Color {
		switch colorScheme {
			case .dark: .black
			case .light: .white
			@unknown default: fatalError("New color scheme??")
		}
	}

	enum SortOption: String, CaseIterable {
		case atomicNumber = "Atomic Number"
		case name = "Name"
		case symbol = "Symbol"
		case atomicMass = "Mass"
	}

	func isBookmarked(_ element: Element) -> Bool {
		bookmarks.contains { $0.elementID == element.atomicNumber }
	}

	func compare(lhs: Element, rhs: Element) -> Bool {
		switch sortBy {
			case .atomicNumber: lhs.atomicNumber < rhs.atomicNumber
			case .name: lhs.name < rhs.name
			case .symbol: lhs.symbol < rhs.symbol
			case .atomicMass: lhs.atomicMass < rhs.atomicMass
		}
	}

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

		if let category = selectedCategory { result = result.filter { $0.series == category } }
		if let phase = selectedPhase { result = result.filter { $0.phase == phase } }
		if let group = selectedGroup { result = result.filter { $0.group == group } }
		if let period = selectedPeriod { result = result.filter { $0.period == period } }
		if let block = selectedBlock { result = result.filter { $0.block == block } }

		switch bookmarkFilter {
			case .onlyBookmarked:
				result = result.filter { isBookmarked($0) }
				result.sort { lhs, rhs in
					let comparison = compare(lhs: lhs, rhs: rhs)
					return sortAscending ? comparison : !comparison
				}
			case .bookmarkedTop:
				result.sort { lhs, rhs in
					let lhsBookmarked = isBookmarked(lhs)
					let rhsBookmarked = isBookmarked(rhs)
					if lhsBookmarked != rhsBookmarked { return lhsBookmarked }
					let comparison = compare(lhs: lhs, rhs: rhs)
					return sortAscending ? comparison : !comparison
				}
			case .all:
				result.sort { lhs, rhs in
					let comparison = compare(lhs: lhs, rhs: rhs)
					return sortAscending ? comparison : !comparison
				}
		}

		return result
	}

	var main: some View {
		ScrollView {
			LazyVStack(spacing: 8) {
				ForEach(filteredElements) { element in
					Button {
						HapticManager.shared.impact()
						selectedElement = element
					} label: {
						HStack {
							Text(element.atomicNumber.description)
								.foregroundStyle(.tertiary)
								.padding(.trailing, 4)

							Text(element.symbol)
								.foregroundStyle(element.series.themeColor)
								.bold()
								.padding(.trailing)

							Spacer()

							Text(element.name)
								.padding(.trailing, 4)

							if isBookmarked(element) {
								Image(systemName: "bookmark.fill")
									.foregroundStyle(.tint)
									.accessibilityLabel("This element is bookmarked")
							}
						}
						.font(.title3)
						.monospaced()
						.padding(10)
						.padding(.leading, 3)
						.background(.gray.opacity(0.2))
						.clipShape(Capsule())
					}
					.dynamicTypeSize(...DynamicTypeSize.accessibility1)
					.buttonStyle(.plain)
					.transition(.blurReplace)
					.matchedTransitionSource(id: element.id, in: namespace)
				}
			}
			.animation(reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.8), value: filteredElements)
			.padding(.horizontal)
		}
	}

	var filters: some View {
		GlassEffectContainer {
			VStack(alignment: .trailing, spacing: 8) {
				Group {
					Picker(selection: $selectedCategory) {
						Text("All")
							.foregroundStyle(.secondary)
							.tag(nil as Category?)
						ForEach(Category.allCases, id: \.self) { category in
							Label(category.rawValue.capitalized, systemImage: category.symbol)
								.foregroundStyle(category.themeColor)
								.tag(category as Category?)
						}
					} label: {
						if selectedCategory == nil {
							Label("Category", systemImage: "line.3.horizontal.decrease.circle")
								.foregroundStyle(.secondary)
						}
					}
					.animation(reduceMotion ? nil : .easeInOut, value: selectedCategory)

					Picker(selection: $selectedPhase) {
						Text("All")
							.foregroundStyle(.secondary)
							.tag(nil as ElementPhase?)
						ForEach(ElementPhase.allCases, id: \.self) { phase in
							Label(phase.rawValue, systemImage: phase.symbol)
								.foregroundStyle(phase.colour)
								.tag(phase as ElementPhase?)
						}
					} label: {
						if selectedPhase == nil {
							Label("Phase", systemImage: "circle.dotted")
								.foregroundStyle(.secondary)
						}
					}
					.animation(reduceMotion ? nil : .easeInOut, value: selectedPhase)

					Picker(selection: $selectedGroup) {
						Text("All")
							.foregroundStyle(.secondary)
							.tag(nil as Int?)
						ForEach(1 ... 18, id: \.self) { group in
							Label("Group \(group)", systemImage: group.description + ".circle")
								.foregroundStyle(colourForGroup(group))
								.tag(group as Int?)
						}
					} label: {
						if selectedGroup == nil {
							Label("Group", systemImage: "chevron.up.chevron.down")
								.foregroundStyle(.secondary)
						}
					}
					.animation(reduceMotion ? nil : .easeInOut, value: selectedGroup)

					Picker(selection: $selectedPeriod) {
						Text("All")
							.foregroundStyle(.secondary)
							.tag(nil as Int?)
						ForEach(1 ... 7, id: \.self) { period in
							Label("Period \(period)", systemImage: period.description + ".square")
								.foregroundStyle(colourForPeriod(period))
								.tag(period as Int?)
						}
					} label: {
						if selectedPeriod == nil {
							Label("Period", systemImage: "chevron.left.chevron.right")
								.foregroundStyle(.secondary)
						}
					}
					.animation(reduceMotion ? nil : .easeInOut, value: selectedPeriod)

					Picker(selection: $selectedBlock) {
						Text("All")
							.foregroundStyle(.secondary)
							.tag(nil as Block?)
						ForEach(Block.allCases, id: \.self) { block in
							Label(block.name.capitalized, systemImage: block.symbol)
								.foregroundStyle(block.colour)
								.tag(block as Block?)
						}
					} label: {
						if selectedBlock == nil {
							Label("Block", systemImage: "square.grid.2x2")
								.foregroundStyle(.secondary)
						}
					}
					.animation(reduceMotion ? nil : .easeInOut, value: selectedBlock)

					Picker(selection: $bookmarkFilter) {
						ForEach(BookmarkFilter.allCases) { filter in
							Text(filter.rawValue)
								.tag(filter)
						}
					} label: {
						if bookmarkFilter == .all {
							Label("Bookmarks", systemImage: "bookmark")
								.foregroundStyle(.secondary)
						}
					}
				}
				.pickerStyle(.navigationLink)
				.padding(.horizontal, 10)
				.padding(.vertical, 7)
				.glassEffect(.clear.interactive())
				.fixedSize()
				.contentShape(Rectangle())
				.foregroundStyle(.secondary)
				.background {
					Rectangle()
						.fill(oppositeForegroundStyle)
						.clipShape(Capsule())
						.blur(radius: 10)
				}
				.dynamicTypeSize(...DynamicTypeSize.accessibility1)
			}
		}
		.onTapGesture {
			filterTip.invalidate(reason: .tipClosed)
		}
		.popoverTip(tipGroup.currentTip as? FilterTip, attachmentAnchor: .point(.bottomTrailing))
	}

	var body: some View {
		NavigationStack {
			main
				.overlay(alignment: .top) {
					if keyboardVisible {
						VariableBlurView(maxBlurRadius: 3, direction: .blurredTopClearBottom)
							.frame(height: 60)
							.ignoresSafeArea()
					}
				}
				.searchable(
					text: $searchText,
					prompt: "Names, series, and more"
				)
				.overlay(alignment: .bottomTrailing) {
					filters
						.padding(.bottom, keyboardVisible ? 70 : 16)
						.padding(.trailing)
				}
				.onChange(of: filteredElements) {
					if filteredElements.count == 1 {
						selectedElement = filteredElements.first
					}
				}
				.toolbar {
					ToolbarItem(placement: .title) {
						Label("List", systemImage: "list.bullet")
							.monospaced()
							.labelStyle(.titleAndIcon)
					}

					ToolbarItem(placement: .topBarTrailing) {
						Menu {
							Picker("Sort By", selection: $sortBy) {
								ForEach(SortOption.allCases, id: \.self) { option in
									Text(option.rawValue)
								}
							}

							Button {
								sortAscending.toggle()
							} label: {
								Label(sortAscending ? "Ascending" : "Descending",
								      systemImage: sortAscending ? "arrow.up" : "arrow.down")
							}
						} label: {
							Label("Sort", systemImage: sortAscending ? "arrow.up" : "arrow.down")
						}
						.menuStyle(.borderlessButton)
						.buttonStyle(.plain)
						.popoverTip(tipGroup.currentTip as? SortTip, attachmentAnchor: .point(.topTrailing))
					}

					ToolbarSpacer(placement: .topBarTrailing)

					ToolbarItem(placement: .topBarTrailing) {
						if
							(selectedCategory != nil) ||
							(selectedPhase != nil) ||
							(selectedGroup != nil) ||
							(selectedPeriod != nil) ||
							(selectedBlock != nil) ||
							(sortBy != .atomicNumber) ||
							!sortAscending ||
							(bookmarkFilter != .all)
						{
							Button {
								selectedCategory = nil
								selectedPhase = nil
								selectedGroup = nil
								selectedPeriod = nil
								selectedBlock = nil
								sortBy = .atomicNumber
								sortAscending = true
								bookmarkFilter = .all
							} label: {
								Label("Reset", systemImage: "arrow.circlepath")
							}
						}
					}
				}
				.animation(.easeInOut, value:
					(selectedCategory != nil) ||
						(selectedPhase != nil) ||
						(selectedGroup != nil) ||
						(selectedPeriod != nil) ||
						(selectedBlock != nil) ||
						(sortBy != .atomicNumber) ||
						!sortAscending ||
						(bookmarkFilter != .all))
				.sheet(item: $selectedElement) { element in
					ElementDetailView(element: element)
						.navigationTransition(.zoom(sourceID: element.id, in: namespace))
				}
				.onAppear {
					NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
						Task { @MainActor in
							withAnimation(.easeInOut) { keyboardVisible = true }
						}
					}
					NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
						Task { @MainActor in
							withAnimation(.easeInOut) { keyboardVisible = false }
						}
					}
				}
				.onDisappear {
					NotificationCenter.default.removeObserver(self)
				}
		}
	}
}
