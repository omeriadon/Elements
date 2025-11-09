//
//  ListView.swift
//  Elements
//
//  Created by Adon Omeri on 8/11/2025.
//
import Portal
import PortalFlowingHeader
import SwiftUI

struct ListView: View {
	let elements: [Element]

	@State var selectedElement: Element? = nil

	var body: some View {
		NavigationStack {
			ScrollView {
				FlowingHeaderView()

				ForEach(elements, id: \.name) { element in
					Button {
						selectedElement = element
					} label: {
						HStack {
							Text(element.symbol)
								.font(.title2)
								.foregroundStyle(element.series.themeColor)
								.fontDesign(.monospaced)
								.portal(item: element, .source)
							Text(element.atomicNumber.description)
								.foregroundStyle(.tertiary)
								.fontDesign(.monospaced)
							Spacer()
							Text(element.name)
								.font(.title3)
						}
						.padding(5)
					}
					.buttonStyle(.glass)
					.padding(.horizontal)
				}
			}
			.flowingHeaderDestination(displays: [.title, .accessory])
			.sheet(item: $selectedElement) { element in
				ElementDetailView(element: element)
			}
			.portalTransition( // Step 4
				item: $selectedElement,
				animation: .smooth(duration: 0.4, extraBounce: 0.1)
			) { element in
				Text(element.symbol)
					.font(.title2)
					.fontDesign(.monospaced)
					.foregroundStyle(element.series.themeColor)
			}
		}
		.flowingHeader(
			title: "List",
			subtitle: "",
			displays: [.title, .accessory]
		) {
			Image(systemName: "list.bullet")
		}
	}
}
