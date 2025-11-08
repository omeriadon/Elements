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
				VStack(spacing: 30) {
					header
					properties
					shells
						.padding(.horizontal, -16)

					info
				}
				.padding(.horizontal)
			}
			.flowingHeaderDestination(displays: [.title])
		}
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
				VStack(alignment: .leading) {
					Text("Atomic Number")
						.foregroundStyle(.tertiary)
					Text(element.number.description)
						.fontDesign(.monospaced)
				}

				Spacer()

				VStack(alignment: .trailing) {
					Text("State")
						.foregroundStyle(.tertiary)
					Label(element.phase.rawValue, systemImage: element.phase.symbol)
						.fontDesign(.monospaced)
				}
			}
		}
	}

	var info: some View {
		GroupBox {
			Text(element.summary)

			if let link = URL(string: element.source) {
				Link("Source", destination: link)
					.foregroundStyle(.tertiary)
			} else {
				Text("Source: \(element.source)")
					.foregroundStyle(.tertiary)
			}
		}
	}

	var properties: some View {
		VStack(alignment: .leading, spacing: 20) {
			VStack(alignment: .leading) {
				Text("Atomic Mass")
					.font(.caption)
					.foregroundStyle(.tertiary)
				Text(element.atomic_mass.description)
			}
			VStack(alignment: .leading) {
				Text("Appearance")
					.font(.caption)
					.foregroundStyle(.tertiary)
				Text(element.appearance ?? "Unknown")
			}
			VStack(alignment: .leading) {
				Text("Boiling Point")
					.font(.caption)
					.foregroundStyle(.tertiary)
				Text(element.boil?.description ?? "Unknown")
			}
		}
	}

	var shells: some View {
		ZStack {
			Text(element.symbol)
				.padding(10)
				.glassEffect(.clear.interactive())

			ForEach(element.shells.indices, id: \.self) { i in
				let shell = element.shells[i]
				let radius = CGFloat(90 + i * 20)

				Circle()
					.stroke(Color.accentColor.tertiary, lineWidth: 1)
					.frame(width: radius, height: radius)

				ForEach(0 ..< shell, id: \.self) { j in
					let angle = Double(j) / Double(shell) * 360.0
					Circle()
						.fill(Color.accentColor)
						.frame(width: 10, height: 10)
						.offset(y: -radius / 2)
						.rotationEffect(.degrees(angle))
				}
			}
		}
		.padding(.vertical)
	}
}
