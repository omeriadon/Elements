//
//  TableView.swift
//  Elements
//
//  Created by Adon Omeri on 8/11/2025.
//

import SwiftUI

let elementCellHeight = 80

struct ElementCell: View {
	let element: Element

	var body: some View {
		VStack(spacing: 2) {
			Text("\(element.atomicNumber)")
				.font(.footnote)
			Text(element.symbol)
				.font(.title2)
			Text(element.name)
				.font(.footnote)
		}
		.frame(
			width: CGFloat(elementCellHeight),
			height: CGFloat(elementCellHeight)
		)
		.background(element.series.themeColor.secondary, in: RoundedRectangle(cornerRadius: 10))
	}
}

struct TableView: View {
	let elements: [Element]

	@State private var scale: CGFloat = 1.0
	@State private var lastScale: CGFloat = 1.0

	private let columns: [GridItem] = Array(
		repeating: .init(
			.fixed(CGFloat(elementCellHeight)),
			alignment: .center
		),
		count: 22
	)

	private var positionedElements: [PlacedElement] {
		elements.map { element in
			var row = element.period - 1 + 3
			var column = element.group - 1 + 2

			switch element.series {
			case .lanthanide:
				row = 8 + 3
				column = (element.atomicNumber - 57) + 2 + 2

			case .actinide:
				row = 9 + 3
				column = (element.atomicNumber - 89) + 2 + 2

			default:
				break
			}

			return PlacedElement(element: element, row: row, column: column)
		}
	}

	var body: some View {
		NavigationStack {
			ScrollView([.horizontal, .vertical]) {
				LazyVGrid(columns: columns, spacing: 0) {
					ForEach(0 ..< 16, id: \.self) { row in
						ForEach(0 ..< 22, id: \.self) { column in
							Group {
								if row == 2 && column >= 2 && column < 20 {
									Text("\(column - 1)")
										.font(.caption2)
										.foregroundColor(.secondary)

								} else if column == 1 && row >= 3 && row < 13 {
									Text("\(row - 2)")
										.font(.caption2)
										.foregroundColor(.secondary)

								} else if let placed = positionedElements.first(where: {
									$0.row == row && $0.column == column
								}) {
									ElementCell(element: placed.element)
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
				.scaleEffect(scale)
			}
			.gesture(
				MagnificationGesture()
					.onChanged { value in
						scale = min(max(lastScale * value, 0.5), 3.0)
					}
					.onEnded { _ in
						lastScale = scale
					}
			)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button {
						withAnimation(.interpolatingSpring(stiffness: 100, damping: 15)) {
							scale = 1.0
							lastScale = 1.0
						}
					} label: {
						Image(systemName: "arrow.counterclockwise")
					}
				}
			}
		}
	}

	private struct PlacedElement: Identifiable {
		let id = UUID()
		let element: Element
		let row: Int
		let column: Int
	}
}
