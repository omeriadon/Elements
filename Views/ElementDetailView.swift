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

					mechanical

					Divider()

					magnetic

					Divider()

					electrical

					Divider()

					crystal

					Divider()

					nuclear

					Divider()

					other

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
						Text(String(format: "%.1f", radius) + " pm")
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

	var magnetic: some View {
		VStack(spacing: 20) {
			if let magneticType = element.magneticType {
				LeftRight {
					Text("Magnetic Type")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(magneticType.rawValue)
						.fontDesign(.monospaced)
				}
			}

			if let magneticSusceptibility = element.magneticSusceptibility {
				LeftRight {
					Text("Magnetic Susceptibility - Mass")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", magneticSusceptibility.mass) + " m³/Kg")
						.fontDesign(.monospaced)
				}

				LeftRight {
					Text("Magnetic Susceptibility - Molar")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(
						String(
							format: "%.3f",
							magneticSusceptibility
								.molar
						) + " m³/mol"
					)
					.fontDesign(.monospaced)
				}

				LeftRight {
					Text("Magnetic Susceptibility - Volume")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", magneticSusceptibility.volume))
						.fontDesign(.monospaced)
				}
			}
		}
	}

	var electrical: some View {
		VStack(spacing: 20) {
			if let conductivity = element.conductivity {
				LeftRight {
					Text("Thermal Conductivity")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", conductivity.thermal))
						.fontDesign(.monospaced)
				}

				LeftRight {
					Text("Electrical Conductivity")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", conductivity.electric))
						.fontDesign(.monospaced)
				}
			}

			if let resistivity = element.resistivity {
				LeftRight {
					Text("Thermal Conductivity")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", resistivity) + " m Ω")
						.fontDesign(.monospaced)
				}
			}

			if let electricalType = element.electricalType {
				LeftRight {
					Text("Electrical Type")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(electricalType.rawValue.capitalized)
						.fontDesign(.monospaced)
				}
			}

			if let electronAffinity = element.electronAffinity {
				LeftRight {
					Text("Electron Affinity")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", electronAffinity) + " kJ/mol")
						.fontDesign(.monospaced)
				}
			}
			if let electronegativityPauling = element.electronegativityPauling {
				LeftRight {
					Text("Pauling Electronegativity")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", electronegativityPauling) + " kJ/mol")
						.fontDesign(.monospaced)
				}
			}

			if let ionizationEnergies = element.ionizationEnergies {
				LeftRight {
					Text("Ionization Energies (kJ/mol)")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(ionizationEnergies.map { String(format: "%.3f", $0) }.joined(separator: "\n"))
						.fontDesign(.monospaced)
				}
			}
		}
	}

	var crystal: some View {
		VStack(spacing: 20) {
			if let crystalStructure = element.crystalStructure {
				LeftRight {
					Text("Crystal Structure")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(crystalStructure.name)
						.fontDesign(.monospaced)
				}
			}

			if let latticeAngles = element.latticeAngles {
				LeftRight {
					Text("Lattice Angles")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(latticeAngles)
						.fontDesign(.monospaced)
				}
			}

			if let latticeConstants = element.latticeConstants {
				LeftRight {
					Text("Lattice Constants")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(latticeConstants)
						.fontDesign(.monospaced)
				}
			}

			if let spaceGroupName = element.spaceGroupName {
				LeftRight {
					Text("Space Group Name")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(spaceGroupName)
						.fontDesign(.monospaced)
				}
			}

			if let spaceGroupNumber = element.spaceGroupNumber {
				LeftRight {
					Text("Space Group Number")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(spaceGroupNumber.description)
						.fontDesign(.monospaced)
				}
			}
		}
	}

	var nuclear: some View {
		VStack(spacing: 20) {
			if let isotopesKnown = element.isotopesKnown {
				LeftRight {
					Text("Known Isotopes")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(isotopesKnown)
						.fontDesign(.monospaced)
				}
			}

			if let isotopicAbundances = element.isotopicAbundances {
				LeftRight {
					Text("Isotope Abundances")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(isotopicAbundances)
						.fontDesign(.monospaced)
				}
			}

			if case .stable = element.halfLife {
				LeftRight {
					Text("Radioactivity")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text("Stable")
						.fontDesign(.monospaced)
				}
			} else if case let .unstable(halfLife) = element.halfLife {
				LeftRight {
					Text("Half Life")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(String(format: "%.3f", halfLife) + " years")
						.fontDesign(.monospaced)
				}
			}

			if case let .unstable(lifetime) = element.lifetime {
				LeftRight {
					Text("Lifetime")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", lifetime) + " years")
						.fontDesign(.monospaced)
				}
			}

			if let decayMode = element.decayMode {
				LeftRight {
					Text("Decay Type")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(decayMode.name)
						.fontDesign(.monospaced)
				}
			}

			if let neutronCrossSection = element.neutronCrossSection {
				LeftRight {
					Text("Neutron Cross Section")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", neutronCrossSection))
						.fontDesign(.monospaced)
				}
			}

			if let neutronMassAbsorption = element.neutronMassAbsorption {
				LeftRight {
					Text("Neutron Mass Absorption")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", neutronMassAbsorption))
						.fontDesign(.monospaced)
				}
			}
		}
	}

	var other: some View {
		VStack(spacing: 20) {
			LeftRight {
				Text("Abundance")
					.font(.caption)
					.foregroundStyle(.tertiary)

			} right: {
				Group {
					if element.abundance == .synthetic {
						Text("Synthetic")
					} else {
						VStack(alignment: .trailing) {
							Text(
								"Universe: " + String(
									format: "%.3f",
									element.abundance.universe
								) + "%"
							)
							Text(
								"Solar: " + String(
									format: "%.3f",
									element.abundance.solar
								) + "%"
							)
							Text(
								"Meteor: " + String(
									format: "%.3f",
									element.abundance.meteor
								) + "%"
							)
							Text(
								"Crust: " + String(
									format: "%.3f",
									element.abundance.crust
								) + "%"
							)
							Text(
								"Ocean: " + String(
									format: "%.3f",
									element.abundance.ocean
								) + "%"
							)
							Text(
								"Human: " + String(
									format: "%.3f",
									element.abundance.human
								) + "%"
							)
						}
						.fontDesign(.monospaced)
					}
				}
			}

			if let adiabaticIndex = element.adiabaticIndex {
				LeftRight {
					Text("Adiabatic Index")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(adiabaticIndex)
						.fontDesign(.monospaced)
				}
			}

			LeftRight {
				Text("Energy Levels")
					.font(.caption)
					.foregroundStyle(.tertiary)

			} right: {
				Text(element.energyLevels)
					.fontDesign(.monospaced)
			}

			if let gasPhase = element.gasPhase {
				LeftRight {
					Text("Gas Phase")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(gasPhase.rawValue.capitalized)
						.fontDesign(.monospaced)
				}
			}

			if let molarVolume = element.molarVolume {
				LeftRight {
					Text("Gas Phase")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.4f", molarVolume))
						.fontDesign(.monospaced)
				}
			}

			if let radius = element.radius {
				if let calculated = radius.calculated {
					LeftRight {
						Text("Calculated Radius")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.4f", calculated) + " pm")
							.fontDesign(.monospaced)
					}
				}

				if let empirical = radius.empirical {
					LeftRight {
						Text("Empirical Radius")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.4f", empirical) + " pm")
							.fontDesign(.monospaced)
					}
				}

				if let covalent = radius.covalent {
					LeftRight {
						Text("Covalent Radius")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.4f", covalent) + " pm")
							.fontDesign(.monospaced)
					}
				}

				if let vanderwaals = radius.vanderwaals {
					LeftRight {
						Text("Vanderwaals Radius")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.4f", vanderwaals) + " pm")
							.fontDesign(.monospaced)
					}
				}

				if let refractiveIndex = element.refractiveIndex {
					LeftRight {
						Text("Refractive Index")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", refractiveIndex))
							.fontDesign(.monospaced)
					}
				}

				if let allotropes = element.allotropes {
					LeftRight {
						Text("Allotropes")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(allotropes)
							.fontDesign(.monospaced)
					}
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
