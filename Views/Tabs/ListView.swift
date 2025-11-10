//
//  ListView.swift
//  Elements
//
//  Created by Adon Omeri on 8/11/2025.
//

import SwiftUI

struct ListView: View {
	let elements: [Element]

	@State var selectedElement: Element? = nil

	var body: some View {
		NavigationStack {
			ScrollView {
				ForEach(elements) { element in
					Button {
						selectedElement = element
					} label: {
						HStack {
							Text(element.symbol)
								.font(.title2)
								.foregroundStyle(element.series.themeColor)
								.fontDesign(.monospaced)
								.bold()
							Text(element.atomicNumber.description)
								.foregroundStyle(.tertiary)
								.fontDesign(.monospaced)
							Spacer()
							Text(element.name)
								.font(.title3)
						}
						.padding(5)
					}
					.tint(.primary)
					.padding()
					.background(.ultraThinMaterial)
					.clipShape(RoundedRectangle(cornerRadius: 25))
					.padding(.horizontal)
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
}
