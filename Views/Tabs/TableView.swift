//
//  TableView.swift
//  Elements
//
//  Created by Adon Omeri on 8/11/2025.
//

import Portal
import SwiftUI

let elementCellHeight = 80

struct ElementCell: View {
	let element: Element

	@State var isPressed = false

	var body: some View {
		VStack(spacing: 2) {
			Text("\(element.atomicNumber)")
				.font(.footnote.monospacedDigit())
			Text(element.symbol)
				.portal(item: element, .source)
				.font(.title2)
				.foregroundStyle(element.series.themeColor)
				.fontDesign(.monospaced)
				.bold()
			Text(element.name)
				.font(.footnote)
		}
		.frame(width: CGFloat(elementCellHeight), height: CGFloat(elementCellHeight))
		.background(element.series.themeColor.tertiary, in: RoundedRectangle(cornerRadius: 10))
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

	@State var scale: CGFloat = 1.0
	@State var selectedElement: Element? = nil

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
				row = 11
				column = (element.atomicNumber - 57) + 4

			case .actinide:
				row = 12
				column = (element.atomicNumber - 89) + 4

			default:
				break
			}

			return PlacedElement(element: element, row: row, column: column)
		}
	}

	var body: some View {
		NavigationStack {
			ScrollView([.horizontal, .vertical]) {
				LazyVGrid(columns: columns) {
					ForEach(0 ..< 16, id: \.self) { row in
						ForEach(0 ..< 22, id: \.self) { column in
							Group {
								if row == 2 && column >= 2 && column < 20 {
									Text("\(column - 1)")
										.font(.caption2.monospacedDigit())
										.foregroundColor(.secondary)

								} else if column == 1 && row >= 3 && row < 13 {
									Text("\(row - 2)")
										.font(.caption2.monospacedDigit())
										.foregroundColor(.secondary)

								} else if let placed = positionedElements.first(where: { $0.row == row && $0.column == column }) {
									ElementCell(element: placed.element)
										.onTapGesture {
											selectedElement = placed.element
										}
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
				.gesture(
					MagnificationGesture()
						.onChanged { value in
							scale = value
						}
						.onEnded { value in
							withAnimation(.spring()) {
								scale = min(max(value, 0.5), 3.0)
							}
						}
				)
				.scaleEffect(scale)
			}
			.sheet(item: $selectedElement) { element in
				ElementDetailView(element: element)
			}
			.portalTransition(
				item: $selectedElement,
				animation: .smooth(duration: 0.4, extraBounce: 0.1)
			) { element in
				Text(element.symbol)
					.font(.title2)
					.foregroundStyle(element.series.themeColor)
					.fontDesign(.monospaced)
					.bold()
			}
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button {
						withAnimation(.interpolatingSpring(stiffness: 100, damping: 15)) {
							scale = 1.0
						}
					} label: {
						Image(systemName: "arrow.counterclockwise")
					}
				}
			}
		}
	}
}
