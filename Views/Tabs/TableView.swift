//
//  TableView.swift
//  Elements
//
//  Created by Adon Omeri on 8/11/2025.
//

import SwiftUI

struct ElementCell: View {
	let element: Element

	var body: some View {
		VStack(spacing: 2) {
			Text(element.symbol)
				.font(.headline)
			Text("\(element.atomicNumber)")
				.font(.caption)
			Text(element.name)
				.font(.footnote)
		}
		.frame(width: 55, height: 55)
		.background(.blue.opacity(0.3))
		.cornerRadius(6)
	}
}

struct TableView: View {
	let elements: [Element]

	private let columns: [GridItem] = Array(
		repeating: .init(.fixed(50), alignment: .top),
		count: 18
	)

	private var positionedElements: [PlacedElement] {
		elements.map { element in
			var row = element.period - 1
			var column = element.group - 1

			switch element.series {
			case .lanthanide:
				// Move them to the lanthanide row, offset by series index
				row = 7 // below main table (example row index)
				column = (element.atomicNumber - 57) + 2 // starts at La = 57
			case .actinide:
				row = 8 // actinide row
				column = (element.atomicNumber - 89) + 2 // starts at Ac = 89
			default:
				break
			}

			return PlacedElement(element: element, row: row, column: column)
		}
	}

	var body: some View {
		ScrollView([.horizontal, .vertical]) {
			LazyVGrid(columns: columns) {
				ForEach(0 ..< 9, id: \.self) { row in
					ForEach(0 ..< 18, id: \.self) { column in
						Group {
							if let placed = positionedElements.first(where: {
								$0.row == row && $0.column == column
							}) {
								ElementCell(element: placed.element)
							} else {
								Color.clear.frame(width: 50, height: 50)
							}
						}
						.padding(10)
					}
				}
			}
			.padding()
		}
	}


	private struct PlacedElement: Identifiable {
		let id = UUID()
		let element: Element
		let row: Int
		let column: Int
	}
}
