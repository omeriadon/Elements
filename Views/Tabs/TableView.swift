//
//  TableView.swift
//  Elements
//
//  Created by Adon Omeri on 8/11/2025.
//

import SwiftData
import SwiftUI
import TipKit

let elementCellHeight = 80

struct PlacedElement: Identifiable {
	let id = UUID()
	let element: Element
	let row: Int
	let column: Int
}

struct ElementCell: View {
	let element: Element
	var action: () -> Void
	var highlightBookmarks: Bool

	@Environment(\.modelContext) private var modelContext
	@Query private var bookmarks: [Bookmark]
	@AppStorage("showRelativeAtomicMass") var showRelativeAtomicMass: Bool = false

	init(element: Element, action: @escaping () -> Void, highlightBookmarks: Bool) {
		self.element = element
		self.action = action
		self.highlightBookmarks = highlightBookmarks
		let id = element.atomicNumber
		_bookmarks = Query(filter: #Predicate {
			$0.elementID == id
		})
	}

	var isBookmarked: Bool {
		!bookmarks.isEmpty
	}

	var body: some View {
		Button {
			action()
		} label: {
			ZStack(alignment: .topTrailing) {
				VStack(spacing: showRelativeAtomicMass ? 1 : 2) {
					Text("\(element.atomicNumber)")
						.font(.footnote.monospacedDigit())
						.dynamicTypeSize(...DynamicTypeSize.medium)

					Text(element.symbol)
						.font(.title2)
						.foregroundStyle(element.series.themeColor)
						.fontDesign(.monospaced)
						.bold()
						.dynamicTypeSize(...DynamicTypeSize.medium)

					Text(element.name)
						.font(.footnote)
						.dynamicTypeSize(...DynamicTypeSize.large)

					if showRelativeAtomicMass {
						Text(element.atomicMass, format: .number.precision(.fractionLength(3)))
							.font(.footnote.monospacedDigit())
							.dynamicTypeSize(...DynamicTypeSize.medium)
					}
				}
				.tint(.secondary)
				.frame(width: CGFloat(elementCellHeight), height: CGFloat(elementCellHeight))
				.background(element.series.themeColor.tertiary, in: RoundedRectangle(cornerRadius: 10))

				if isBookmarked {
					Image(systemName: "bookmark.fill")
						.font(.body)
						.dynamicTypeSize(...DynamicTypeSize.large)
						.foregroundStyle(.tint)
						.padding(4)
						.dynamicTypeSize(...DynamicTypeSize.xxLarge)
						.accessibilityLabel("Bookmark")
						.accessibilityHint("This element is bookmarked")
				}
			}
			.opacity(highlightBookmarks && !isBookmarked ? 0.5 : 1.0)
			.animation(.easeInOut(duration: 0.2), value: highlightBookmarks)
		}
		.contextMenu {
			Button {
				if let existing = bookmarks.first {
					modelContext.delete(existing)
				} else {
					let bookmark = Bookmark(elementID: element.atomicNumber, dateAdded: Date.now)
					modelContext.insert(bookmark)
				}
				try? modelContext.save()
			} label: {
				Label(
					isBookmarked ? "Remove Bookmark" : "Add Bookmark",
					systemImage: isBookmarked ? "bookmark.slash" : "bookmark"
				)
			}
		}
	}
}

struct TableView: View {
	let elements: [Element]

	@State var selectedElement: Element? = nil

	@State var pressedAnElement = false

	let columns: [GridItem] = Array(
		repeating: .init(
			.fixed(CGFloat(elementCellHeight)),
			alignment: .center
		),
		count: 19
	)

	let tableViewTip = TableViewTip()

	@Namespace var namespace

	@State var highlightBookmarks = false

	var positionedElements: [PlacedElement] {
		elements.map { element in
			var row = element.period + 2
			var column = element.group + 1

			switch element.series {
				case .lanthanide:
					row = 11
					column = element.atomicNumber - 53

				case .actinide:
					row = 12
					column = element.atomicNumber - 85

				default:
					break
			}

			return PlacedElement(element: element, row: row, column: column)
		}
	}

	private func handleElementTap(_ element: Element) {
		HapticManager.shared.impact()
		tableViewTip.invalidate(reason: .actionPerformed)
		selectedElement = element
	}

	var main: some View {
		ScrollView([.horizontal, .vertical]) {
			LazyVGrid(columns: columns) {
				ForEach(2 ..< 13, id: \.self) { row in
					ForEach(1 ..< 20, id: \.self) { column in
						Group {
							if row == 2, column >= 2, column < 20 {
								Text("\(column - 1)")
									.font(.caption2.monospacedDigit())
									.foregroundColor(.secondary)

							} else if column == 1, row >= 3, row < 13 {
								Text("\(row - 2)")
									.font(.caption2.monospaced())
									.foregroundColor(.secondary)

							} else if let placed = positionedElements.first(where: { $0.row == row && $0.column == column }) {
								ElementCell(
									element: placed.element,
									action: { handleElementTap(placed.element) },
									highlightBookmarks: highlightBookmarks
								)
								.matchedTransitionSource(id: placed.element.id, in: namespace)
							} else {
								Color.clear
							}
						}
						.frame(
							width: CGFloat(elementCellHeight),
							height: CGFloat(elementCellHeight)
						)
					}
				}
			}
			.padding(.bottom, 100)
			.padding(.trailing, 20)
			.padding(.top, 80)
		}
	}

	var body: some View {
		NavigationStack {
			main
				.ignoresSafeArea()
				.sheet(item: $selectedElement) { element in
					ElementDetailView(element: element)
						.navigationTransition(.zoom(sourceID: element.id, in: namespace))
				}
				.toolbar {
					ToolbarItem(placement: .title) {
						Label("Table", systemImage: "atom")
							.monospaced()
							.labelStyle(.titleAndIcon)
					}

					ToolbarItem(placement: .topBarTrailing) {
						Button {
							highlightBookmarks.toggle()
						} label: {
							Group {
								if highlightBookmarks {
									Label("Unhighlight Bookmarks", systemImage: "bookmark.fill")
										.transition(.blurReplace)
								} else {
									Label("Highlight Bookmarks", systemImage: "bookmark")
										.transition(.blurReplace)
								}
							}
							.animation(.easeInOut, value: highlightBookmarks)
						}
					}
				}
				.overlay(alignment: .bottom) {
					TipView(tableViewTip)
						.padding(.bottom)
						.padding()
				}
		}
	}
}
