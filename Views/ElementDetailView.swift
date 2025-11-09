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
	@Environment(\.dismiss) private var dismiss
	let element: Element
	@State private var rotation = 0.0

	var body: some View {
		NavigationStack {
			ScrollView {
				FlowingHeaderView()
				VStack(spacing: 30) {
					general

					Divider()

					shells
						.padding(.horizontal, -16)

					Divider()

					atomicStructure

					Divider()

					thermoDynamic

					Divider()

					classification

					Divider()

					info
				}
				.padding(.horizontal)
			}
			.flowingHeaderDestination(displays: [.title])
			.toolbar {
				Button(role: .close) {
					dismiss()
				}
			}
		}
		.flowingHeader(
			title: element.name,
			subtitle: "",
			displays: []
		)
	}

	var general: some View {
		VStack(spacing: 15) {
			HStack {
				Text(element.symbol)
					.portal(item: element, .destination)
					.font(.title2)
					.foregroundStyle(element.series.themeColor)
					.frame(width: 100, height: 100)
					.glassEffect(.clear.interactive())
					.padding(.leading, 10)
					.fontDesign(.monospaced)
				Spacer()
				VStack(alignment: .trailing) {
					if let discovered = element.discovered {
						Text("Discovered " + discovered.year.description)
							.foregroundStyle(.tertiary)
							.fontDesign(.monospaced)
					}
					Text(element.name)
						.font(.title)
						.fontDesign(.monospaced)
						.fontWeight(.heavy)
					if let alternateNames = element.alternateNames {
						Text("Alternate: " + alternateNames.capitalized)
							.foregroundStyle(.tertiary)
					}
					Text(element.series.rawValue.capitalized)
						.fontDesign(.monospaced)
						.foregroundStyle(element.series.themeColor)
				}
			}

			HStack {
				VStack(alignment: .leading) {
					Text("Atomic Number")
						.foregroundStyle(.tertiary)
					Text(element.atomicNumber.description)
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

	var shells: some View {
		ZStack {
			Text(element.symbol)
				.padding(10)
				.glassEffect(
					.clear.tint(element.series.themeColor).interactive(),
					in: .circle
				)

			ForEach(element.electronsPerShell.indices, id: \.self) { i in
				let shell = element.electronsPerShell[i]
				let radius = CGFloat(50 + i * 28)

				Circle()
					.stroke(Color.accentColor.tertiary, lineWidth: 1)
					.frame(width: radius * 1.5, height: radius * 1.5)

				ForEach(0 ..< shell, id: \.self) { j in
					let angle = Double(j) / Double(shell) * 360.0
					Circle()
						.fill(Color.accentColor)
						.frame(width: 10, height: 10)
						.offset(y: -radius / 1.333333333333333)
						.rotationEffect(.degrees(angle))
						.rotationEffect(.degrees(rotation))
						.onAppear {
							withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
								rotation = 360
							}
						}
				}
			}
		}
		.padding(.vertical)
	}

	var atomicStructure: some View {
		VStack(spacing: 20) {
			LeftRight {
				Text("Atomic Mass")
					.font(.caption)
					.foregroundStyle(.tertiary)

			} right: {
				Text(String(format: "%.3f", element.atomicMass) + " amu")
					.fontDesign(.monospaced)
			}

			if let valenceElectrons = element.valenceElectrons {
				LeftRight {
					Text("Valence Electrons")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(valenceElectrons.description)
						.fontDesign(.monospaced)
				}
			}

			LeftRight {
				Text("Electron Configuration")
					.font(.caption)
					.foregroundStyle(.tertiary)

			} right: {
				Text(element.electronConfiguration)
					.fontDesign(.monospaced)
			}

			LeftRight {
				Text("Semantic Electron Configuration")
					.font(.caption)
					.foregroundStyle(.tertiary)

			} right: {
				Text(element.electronConfigurationSemantic)
					.fontDesign(.monospaced)
			}

			LeftRight {
				Text("Quantum Numbers")
					.font(.caption)
					.foregroundStyle(.tertiary)

			} right: {
				Text(element.quantumNumbers)
					.fontDesign(.monospaced)
			}

			if let oxidationStates = element.oxidationStates {
				LeftRight {
					Text("Oxidation States")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(oxidationStates)
						.fontDesign(.monospaced)
				}
			}
		}
	}

	var thermoDynamic: some View {
		VStack(spacing: 20) {
			if let meltingPoint = element.meltingPoint {
				LeftRight {
					Text("Melting Point")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", meltingPoint) + " °K")
						.fontDesign(.monospaced)
				}
			}

			if let boilingPoint = element.boilingPoint {
				LeftRight {
					Text("Boiling Point")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", boilingPoint) + " °K")
						.fontDesign(.monospaced)
				}
			}

			if let criticalTemperature = element.criticalTemperature {
				LeftRight {
					Text("Critical Temperature")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", criticalTemperature) + " °K")
						.fontDesign(.monospaced)
				}
			}

			if let criticalPressure = element.criticalPressure {
				LeftRight {
					Text("Critical Pressure")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", criticalPressure) + " °K")
						.fontDesign(.monospaced)
				}
			}

			if let curiePoint = element.curiePoint {
				LeftRight {
					Text("Curie Point")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", curiePoint) + " °K")
						.fontDesign(.monospaced)
				}
			}

			if let neelPoint = element.neelPoint {
				LeftRight {
					Text("Neel Point")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", neelPoint) + " °K")
						.fontDesign(.monospaced)
				}
			}

			if let superconductingPoint = element.superconductingPoint {
				LeftRight {
					Text("Superconducting Point")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", superconductingPoint) + " °K")
						.fontDesign(.monospaced)
				}
			}

			if let thermalExpansion = element.thermalExpansion {
				LeftRight {
					Text("Thermal Expansion")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", thermalExpansion) + " °K")
						.fontDesign(.monospaced)
				}
			}

			if let heat = element.heat {
				if let specific = heat.specific {
					LeftRight {
						Text("Specific Heat")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", specific) + " J/(kg K)")
							.fontDesign(.monospaced)
					}
				}

				if let fusion = heat.fusion {
					LeftRight {
						Text("Heat of Fusion")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", fusion) + " kJ/mol")
							.fontDesign(.monospaced)
					}
				}
				if let vaporization = heat.vaporization {
					LeftRight {
						Text("Heat of vaporization")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", vaporization) + " kJ/mol")
							.fontDesign(.monospaced)
					}
				}

				if let molar = heat.molar {
					LeftRight {
						Text("Molar heat capacity")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", molar) + " J/K.mol")
							.fontDesign(.monospaced)
					}
				}
			}
		}
	}

	var classification: some View {
		VStack(spacing: 20) {
			LeftRight {
				Text("Block")
					.font(.caption)
					.foregroundStyle(.tertiary)

			} right: {
				Text(element.block.name)
					.fontDesign(.monospaced)
			}

			LeftRight {
				Text("Group")
					.font(.caption)
					.foregroundStyle(.tertiary)

			} right: {
				Text(element.group.description)
					.fontDesign(.monospaced)
			}

			LeftRight {
				Text("Period")
					.font(.caption)
					.foregroundStyle(.tertiary)

			} right: {
				Text(element.period.description)
					.fontDesign(.monospaced)
			}

			LeftRight {
				Text("CAS Number")
					.font(.caption)
					.foregroundStyle(.tertiary)

			} right: {
				Text(element.classifications.casNumber)
					.fontDesign(.monospaced)
			}

			if let cidNumber = element.classifications.cidNumber {
				LeftRight {
					Text("CID Number")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(cidNumber)
						.fontDesign(.monospaced)
				}
			}

			if let rtecsNumber = element.classifications.rtecsNumber {
				LeftRight {
					Text("RTECS Number")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(rtecsNumber)
						.fontDesign(.monospaced)
				}
			}

			if let dotNumbers = element.classifications.dotNumbers {
				LeftRight {
					Text("DOT Number")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(dotNumbers.description)
						.fontDesign(.monospaced)
				}
			}

			if let dotHazardClass = element.classifications.dotHazardClass {
				LeftRight {
					Text("Dot Hazard Class")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(dotHazardClass.description)
						.fontDesign(.monospaced)
				}
			}
		}
	}

	var mechanical: some View {
		VStack(spacing: 20) {
			if let density = element.density {
				if let shear = density.shear {
					LeftRight {
						Text("Shear modulus")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", shear) + " GPa")
							.fontDesign(.monospaced)
					}
				}

				if let young = density.young {
					LeftRight {
						Text("Young modulus")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", young) + " GPa")
							.fontDesign(.monospaced)
					}
				}

				if let stp = density.stp {
					LeftRight {
						Text("Standard density")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", stp) + " kg/m³")
							.fontDesign(.monospaced)
					}
				}

				if let liquid = density.liquid {
					LeftRight {
						Text("Liquid Density")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", liquid) + " kg/m³")
							.fontDesign(.monospaced)
					}
				}
			}

			if let hardness = element.hardness {
				if let radius = hardness.radius {
					LeftRight {
						Text("Atomic/ionic radius hardness")
							.font(.caption)
							.foregroundStyle(.tertiary)
					} right: {
						Text(String(format: "%.3f", radius) + " pm")
							.fontDesign(.monospaced)
					}
				}

				if let vickers = hardness.vickers {
					LeftRight {
						Text("Vickers hardness")
							.font(.caption)
							.foregroundStyle(.tertiary)
					} right: {
						Text(String(format: "%.3f", vickers) + " MPa")
							.fontDesign(.monospaced)
					}

					// Compute Mohs 1-10 from Vickers
					let mohsValue: Int = {
						switch vickers {
						case 0 ..< 60: return 1
						case 60 ..< 120: return 2
						case 120 ..< 200: return 3
						case 200 ..< 400: return 4
						case 400 ..< 500: return 5
						case 500 ..< 700: return 6
						case 700 ..< 1000: return 7
						case 1000 ..< 1200: return 8
						case 1200 ..< 1400: return 9
						default: return 10
						}
					}()

					LeftRight {
						Text("Mohs (1–10)")
							.font(.caption)
							.foregroundStyle(.tertiary)
					} right: {
						Text(mohsValue.description)
							.fontDesign(.monospaced)
					}
				}

				if let mohs = hardness.mohs {
					LeftRight {
						Text("Mohs hardness (MPa)")
							.font(.caption)
							.foregroundStyle(.tertiary)
					} right: {
						Text(String(format: "%.3f", mohs) + " MPa")
							.fontDesign(.monospaced)
					}
				}

				if let brinell = hardness.brinell {
					LeftRight {
						Text("Brinell hardness")
							.font(.caption)
							.foregroundStyle(.tertiary)
					} right: {
						Text(String(format: "%.3f", brinell) + " MPa")
							.fontDesign(.monospaced)
					}
				}
			}

			if let modulus = element.modulus, let bulk = modulus.bulk {
				LeftRight {
					Text("Bulk modulus")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(String(format: "%.3f", bulk) + " GPa")
						.fontDesign(.monospaced)
				}
			}

			if let poisson = element.poissonRatio {
				LeftRight {
					Text("Poisson ratio")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(String(format: "%.3f", poisson))
						.fontDesign(.monospaced)
				}
			}

			if let sos = element.speedOfSound {
				LeftRight {
					Text("Speed of sound")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(String(format: "%.3f", sos) + " m/s")
						.fontDesign(.monospaced)
				}
			}
		}
	}

	var info: some View {
		VStack(alignment: .leading) {
			Text(element.summary)
				.padding(.bottom, 20)
				.fontDesign(.serif)
				.textSelection(.enabled)

			if let link = URL(string: element.source) {
				Link(destination: link) {
					Label("Source: \(element.source)", systemImage: "link")
				}
				.foregroundStyle(.tertiary)
			} else {
				Text("Source: \(element.source)")
					.foregroundStyle(.tertiary)
			}
		}
		.padding(15)
		.background(.ultraThinMaterial)
		.clipShape(RoundedRectangle(cornerRadius: 20))
	}
}
