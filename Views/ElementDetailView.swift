//
//  ElementDetailView.swift
//  Elements
//
//  Created by Adon Omeri on 8/11/2025.
//

import Portal
import PortalFlowingHeader
import SwiftUI

struct ElementDetailView: View {
	let element: Element
	var body: some View {
		NavigationStack {
			ScrollView {
				FlowingHeaderView()
				header
			}
			.flowingHeaderDestination(displays: [.title])
		}
		.padding(.horizontal)
		.flowingHeader(
			title: element.name,
			subtitle: "",
			displays: []
		)
	}

	var header: some View {
		VStack(spacing: 15) {
			HStack {
				Text(element.symbol)
					.portal(item: element, .destination)
					.font(.title2)
					.foregroundStyle(element.category.themeColor)
					.frame(width: 100, height: 100)
					.glassEffect(.clear.interactive())
					.padding(.leading, 10)
					.fontDesign(.monospaced)
				Spacer()
				VStack(alignment: .trailing) {
					Text(element.name)
						.font(.title)
						.fontDesign(.monospaced)
						.fontWeight(.heavy)
					Text(element.category.rawValue.capitalized)
						.fontDesign(.monospaced)
						.foregroundStyle(.secondary)
				}
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			HStack {
				Spacer()

				VStack {
					Text("Atomic Number")
						.foregroundStyle(.tertiary)
					Text(element.number.description)
						.fontDesign(.monospaced)
				}

				Spacer()

				VStack {
					Text("State")
						.foregroundStyle(.tertiary)
					Text(element.phase.rawValue)
						.fontDesign(.monospaced)
				}

				Spacer()
			}
		}
	}
}

#Preview {
	ElementDetailView(
		element: Element(
			name: "name",
			appearance: "A massive appearance is here descirbing teh look fo the thing",
			atomic_mass: 1.03,
			boil: 7654,
			category: .lanthanide,
			number: 1,
			period: 6,
			group: 3,
			phase: .liquid,
			source: "wikipedia or smth",
			summary: "summary and info about this element. summary and info about this element. summary and info about this element. summary and info about this element. summary and info about this element. summary and info about this element. summary and info about this element. summary and info about this element. summary and info about this element. summary and info about this element. summary and info about this element. ",
			symbol: "Ne",
			xpos: 1,
			ypos: 1,
			wxpos: 1,
			wypos: 1,
			shells: [1, 4, 3]
		)
	)
}
