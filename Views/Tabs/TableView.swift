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

	private let columns: [GridItem] = Array(
		repeating: .init(
			.fixed(CGFloat(elementCellHeight)),
			alignment: .center
		),
		count: 18
	)

	private var positionedElements: [PlacedElement] {
		elements.map { element in
			var row = element.period - 1
			var column = element.group - 1

			switch element.series {
			case .lanthanide:
				row = 8
				column = (element.atomicNumber - 57) + 2

			case .actinide:
				row = 9
				column = (element.atomicNumber - 89) + 2

			default:
				break
			}

			return PlacedElement(element: element, row: row, column: column)
		}
	}

	var body: some View {
		ScrollView([.horizontal, .vertical]) {
			LazyVGrid(columns: columns) {
				ForEach(0 ..< 10, id: \.self) { row in
					ForEach(0 ..< 18, id: \.self) { column in
						Group {
							if let placed = positionedElements.first(where: {
								$0.row == row && $0.column == column
							}) {
								ElementCell(element: placed.element)
							} else {
								Color.clear
									.frame(
										width: CGFloat(elementCellHeight),
										height: CGFloat(elementCellHeight)
									)
							}
						}
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
