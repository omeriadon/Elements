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

struct ElementCell: View {
	let element: Element
	var action: () -> Void
	@Query private var bookmarks: [Bookmark]

	var isBookmarked: Bool {
		bookmarks.contains { $0.elementID == element.atomicNumber }
	}

	var body: some View {
		Button {
			action()
		} label: {
			ZStack(alignment: .topTrailing) {
				VStack(spacing: 2) {
					Text("\(element.atomicNumber)")
						.font(.footnote.monospacedDigit())
						.dynamicTypeSize(...DynamicTypeSize.xxLarge)

					Text(element.symbol)
						.font(.title2)
						.foregroundStyle(element.series.themeColor)
						.fontDesign(.monospaced)
						.bold()
						.dynamicTypeSize(...DynamicTypeSize.xxLarge)

					Text(element.name)
						.font(.footnote)
						.dynamicTypeSize(...DynamicTypeSize.xxLarge)
				}
				.tint(.secondary)
				.frame(width: CGFloat(elementCellHeight), height: CGFloat(elementCellHeight))
				.background(element.series.themeColor.tertiary, in: RoundedRectangle(cornerRadius: 10))

				if isBookmarked {
					Image(systemName: "bookmark.fill")
						.foregroundStyle(.tint)
						.padding(4)
						.dynamicTypeSize(...DynamicTypeSize.xxLarge)
				}
			}
		}
	}
}

struct PlacedElement: Identifiable {
	let id = UUID()
	let element: Element
	let row: Int
	let column: Int
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

	let tableViewTip = TableViewTip()

	@Namespace var namespace

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
								ElementCell(element: placed.element) {
									HapticManager.shared.impact()
									tableViewTip.invalidate(reason: .actionPerformed)
									selectedElement = placed.element
								}
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
			.padding(20)
			.padding(.bottom, 80)
			.padding([.trailing, .top], 10)
		}
	}

	var body: some View {
		main
			.overlay(alignment: .top) {
				VariableBlurView(maxBlurRadius: 2.5, direction: .blurredTopClearBottom)
					.frame(height: 50)
			}
			.overlay(alignment: .top) {
				TipView(tableViewTip)
					.padding(.top, 40)
					.padding()
			}
			.ignoresSafeArea()
			.sheet(item: $selectedElement) { element in
				ElementDetailView(element: element)
					.navigationTransition(.zoom(sourceID: element.id, in: namespace))
			}
	}
}
