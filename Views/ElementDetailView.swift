//
//  ElementDetailView.swift
//  Elements
//
//  Created by Adon Omeri on 8/11/2025.
//

import SwiftData
import SwiftUI
import TipKit

let bookmarksTip = BookmarksTip()
let copyElementNameTip = CopyElementNameTip()

struct ElementDetailView: View {
	@Environment(\.dismiss) private var dismiss
	@Environment(\.accessibilityReduceMotion) var reduceMotion
	@Environment(\.modelContext) private var modelContext
	@Query private var bookmarks: [Bookmark]

	private var isBookmarked: Bool {
		!bookmarks.isEmpty
	}

	private func toggleBookmark() {
		if let existing = bookmarks.first {
			modelContext.delete(existing)
		} else {
			let bookmark = Bookmark(elementID: element.atomicNumber, dateAdded: Date.now)
			modelContext.insert(bookmark)
		}

		try? modelContext.save()
	}

	let element: Element
	@State private var rotation = 0.0
	@State var isCopied = false

	@AppStorage("show_section_shells") private var showSectionShells: Bool = true
	@AppStorage("show_section_atomicStructure") private var showSectionAtomic: Bool = true
	@AppStorage("show_section_thermoDynamic") private var showSectionThermo: Bool = true
	@AppStorage("show_section_classification") private var showSectionClassification: Bool = true
	@AppStorage("show_section_mechanical") private var showSectionMechanical: Bool = true
	@AppStorage("show_section_magnetic") private var showSectionMagnetic: Bool = true
	@AppStorage("show_section_electrical") private var showSectionElectrical: Bool = true
	@AppStorage("show_section_crystal") private var showSectionCrystal: Bool = true
	@AppStorage("show_section_nuclear") private var showSectionNuclear: Bool = true
	@AppStorage("show_section_other") private var showSectionOther: Bool = true
	@AppStorage("show_section_info") private var showSectionInfo: Bool = true

	// Atomic
	@AppStorage("show_atomic_mass") private var showAtomicMass: Bool = true
	@AppStorage("show_valence_electrons") private var showValenceElectrons: Bool = true
	@AppStorage("show_electron_affinity") private var showElectronAffinity: Bool = true
	@AppStorage("show_electron_configuration") private var showElectronConfiguration: Bool = true
	@AppStorage("show_electron_configuration_semantic") private var showElectronConfigurationSemantic: Bool = true
	@AppStorage("show_electronegativity_pauling") private var showElectronegativityPauling: Bool = true
	@AppStorage("show_electrons_per_shell") private var showElectronsPerShell: Bool = true
	@AppStorage("show_energy_levels") private var showEnergyLevels: Bool = true
	@AppStorage("show_ionization_energies") private var showIonizationEnergies: Bool = true
	@AppStorage("show_quantum_numbers") private var showQuantumNumbers: Bool = true

	// Thermal
	@AppStorage("show_melting_point") private var showMeltingPoint: Bool = true
	@AppStorage("show_boiling_point") private var showBoilingPoint: Bool = true
	@AppStorage("show_critical_temperature") private var showCriticalTemperature: Bool = true
	@AppStorage("show_critical_pressure") private var showCriticalPressure: Bool = true
	@AppStorage("show_curie_point") private var showCuriePoint: Bool = true
	@AppStorage("show_neel_point") private var showNeelPoint: Bool = true
	@AppStorage("show_superconducting_point") private var showSuperconductingPoint: Bool = true
	@AppStorage("show_heat_specific") private var showHeatSpecific: Bool = true
	@AppStorage("show_heat_vaporization") private var showHeatVaporization: Bool = true
	@AppStorage("show_heat_fusion") private var showHeatFusion: Bool = true
	@AppStorage("show_heat_molar") private var showHeatMolar: Bool = true
	@AppStorage("show_adiabatic_index") private var showAdiabaticIndex: Bool = true

	// Classification
	@AppStorage("show_block") private var showBlock: Bool = true
	@AppStorage("show_group") private var showGroupRow: Bool = true
	@AppStorage("show_period") private var showPeriod: Bool = true
	@AppStorage("show_series") private var showSeries: Bool = true
	@AppStorage("show_phase") private var showPhase: Bool = true
	@AppStorage("show_gas_phase") private var showGasPhase: Bool = true
	@AppStorage("show_cas_number") private var showCasNumber: Bool = true
	@AppStorage("show_cid_number") private var showCidNumber: Bool = true
	@AppStorage("show_rtecs_number") private var showRtecsNumber: Bool = true
	@AppStorage("show_dot_numbers") private var showDotNumbers: Bool = true
	@AppStorage("show_dot_hazard_class") private var showDotHazardClass: Bool = true

	// Mechanical
	@AppStorage("show_shear_modulus") private var showShearModulus: Bool = true
	@AppStorage("show_young_modulus") private var showYoungModulus: Bool = true
	@AppStorage("show_standard_density") private var showStandardDensity: Bool = true
	@AppStorage("show_atomic_ionic_radius") private var showAtomicIonicRadius: Bool = true
	@AppStorage("show_vickers_hardness") private var showVickersHardness: Bool = true
	@AppStorage("show_mohs_calculated") private var showMohsCalculated: Bool = true
	@AppStorage("show_mohs_mpa") private var showMohsMPA: Bool = true
	@AppStorage("show_speed_of_sound") private var showSpeedOfSound: Bool = true
	@AppStorage("show_molar_volume") private var showMolarVolume: Bool = true
	@AppStorage("show_radius_empirical") private var showRadiusEmpirical: Bool = true
	@AppStorage("show_radius_covalent") private var showRadiusCovalent: Bool = true
	@AppStorage("show_radius_vanderwaals") private var showRadiusVanderwaals: Bool = true

	// Magnetic
	@AppStorage("show_magnetic_type") private var showMagneticType: Bool = true
	@AppStorage("show_magnetic_susceptibility_mass") private var showMagneticSusceptibilityMass: Bool = true
	@AppStorage("show_magnetic_susceptibility_molar") private var showMagneticSusceptibilityMolar: Bool = true
	@AppStorage("show_magnetic_susceptibility_volume") private var showMagneticSusceptibilityVolume: Bool = true

	// Electrical
	@AppStorage("show_electrical_type") private var showElectricalType: Bool = true
	@AppStorage("show_conductivity_thermal") private var showConductivityThermal: Bool = true

	// Crystal
	@AppStorage("show_crystal_structure") private var showCrystalStructure: Bool = true
	@AppStorage("show_lattice_angles") private var showLatticeAngles: Bool = true
	@AppStorage("show_lattice_constants") private var showLatticeConstants: Bool = true
	@AppStorage("show_space_group_name") private var showSpaceGroupName: Bool = true
	@AppStorage("show_space_group_number") private var showSpaceGroupNumber: Bool = true

	// Nuclear
	@AppStorage("show_known_isotopes") private var showKnownIsotopes: Bool = true
	@AppStorage("show_isotopic_abundances") private var showIsotopicAbundances: Bool = true
	@AppStorage("show_half_life") private var showHalfLife: Bool = true
	@AppStorage("show_lifetime") private var showLifetime: Bool = true
	@AppStorage("show_decay_mode") private var showDecayMode: Bool = true
	@AppStorage("show_neutron_cross_section") private var showNeutronCrossSection: Bool = true
	@AppStorage("show_neutron_mass_absorption") private var showNeutronMassAbsorption: Bool = true

	// Other
	@AppStorage("show_abundance") private var showAbundance: Bool = true
	@AppStorage("show_radius_calculated") private var showRadiusCalculated: Bool = true
	@AppStorage("show_refractive_index") private var showRefractiveIndex: Bool = true
	@AppStorage("show_allotropes") private var showAllotropes: Bool = true
	@AppStorage("show_oxidation_states") private var showOxidationStates: Bool = true
	@AppStorage("show_appearance") private var showAppearance: Bool = true
	@AppStorage("show_cpk_hex") private var showCpkHex: Bool = true
	@AppStorage("show_discovered_year") private var showDiscoveredYear: Bool = true

	// Info
	@AppStorage("show_summary") private var showSummary: Bool = true
	@AppStorage("show_source") private var showSourceRow: Bool = true

	@State private var tipGroup: TipGroup

	init(element: Element) {
		self.element = element
		_tipGroup = State(initialValue: TipGroup(.firstAvailable) {
			bookmarksTip
			copyElementNameTip
		})
		let elementID = element.atomicNumber
		_bookmarks = Query(filter: #Predicate { $0.elementID == elementID })
	}

	var body: some View {
		NavigationStack {
			GeometryReader { geometry in
				ScrollView(.vertical) {
					VStack(alignment: .center, spacing: 30) {
						header

						let sections = visibleSectionViews()

						if !sections.isEmpty {
							Divider()
						}

						ForEach(Array(sections.enumerated()), id: \.offset) { idx, view in
							view
							if idx < sections.count - 1 {
								Divider()
							}
						}
					}
					.padding(.horizontal)
				}
				.dynamicTypeSize(...DynamicTypeSize.accessibility1)
				.scrollIndicatorsFlash(onAppear: true)
				.toolbar {
					ToolbarItem(placement: .topBarLeading) {
						Button {
							bookmarksTip.invalidate(reason: .actionPerformed)
							toggleBookmark()
						} label: {
							Group {
								if isBookmarked {
									Label("Remove Bookmark", systemImage: "bookmark.fill")
										.transition(.blurReplace)
										.accessibilityHint("Removes this element from your bookmarks")
								} else {
									Label("Add Bookmark", systemImage: "bookmark")
										.transition(.blurReplace)
										.accessibilityHint("Adds this element to your bookmarks")
								}
							}
							.animation(reduceMotion ? nil : .easeInOut, value: isBookmarked)
						}
						.buttonStyle(.plain)
						.popoverTip(tipGroup.currentTip as? BookmarksTip, attachmentAnchor: .point(.topLeading))
					}

					ToolbarItem(placement: .topBarTrailing) {
						Button(role: .close) {
							HapticManager.shared.impact()
							dismiss()
						}
					}

					ToolbarItem(placement: .title) {
						Text(element.name)
							.monospaced()
					}

					ToolbarItem(placement: .status) {
						Button {
							copyElementNameTip.invalidate(reason: .actionPerformed)
							UIPasteboard.general.string = element.name
							isCopied = true
						} label: {
							Group {
								if !isCopied {
									Label("Copy", systemImage: "document.on.document")
										.animation(reduceMotion ? nil : .easeInOut, value: isCopied)
										.accessibilityHint("Copy this element's name to your clipboard")
								} else {
									Label("Copied", systemImage: "checkmark")
										.animation(reduceMotion ? nil : .easeInOut, value: isCopied)
										.accessibilityHint("This element is already copied to your clipboard")
								}
							}
							.transition(.blurReplace)
						}
						.popoverTip(tipGroup.currentTip as? CopyElementNameTip, attachmentAnchor: .point(.bottom))
					}
				}
				.frame(width: geometry.size.width)
			}
		}
	}

	private func visibleSectionViews() -> [AnyView] {
		var result: [AnyView] = []

		// shells
		if showSectionShells {
			result.append(AnyView(shells))
		}

		// atomic
		if showSectionAtomic, atomicStructureHasVisibleRow {
			result.append(AnyView(atomicStructure))
		}

		// thermo
		if showSectionThermo, thermoDynamicHasVisibleRow {
			result.append(AnyView(thermoDynamic))
		}

		// classification
		if showSectionClassification, classificationHasVisibleRow {
			result.append(AnyView(classification))
		}

		// mechanical
		if showSectionMechanical, mechanicalHasVisibleRow {
			result.append(AnyView(mechanical))
		}

		// magnetic
		if showSectionMagnetic, magneticHasVisibleRow {
			result.append(AnyView(magnetic))
		}

		// electrical
		if showSectionElectrical, electricalHasVisibleRow {
			result.append(AnyView(electrical))
		}

		// crystal
		if showSectionCrystal, crystalHasVisibleRow {
			result.append(AnyView(crystal))
		}

		// nuclear
		if showSectionNuclear, nuclearHasVisibleRow {
			result.append(AnyView(nuclear))
		}

		// other
		if showSectionOther, otherHasVisibleRow {
			result.append(AnyView(other))
		}

		// info
		if showSectionInfo, infoHasVisibleRow {
			result.append(AnyView(info))
		}

		return result
	}

	private var atomicStructureHasVisibleRow: Bool {
		showAtomicMass ||
			(showValenceElectrons && element.valenceElectrons != nil) ||
			(showElectronAffinity && element.electronAffinity != nil) ||
			showElectronConfiguration ||
			showElectronConfigurationSemantic ||
			(showElectronegativityPauling && element.electronegativityPauling != nil) ||
			showElectronsPerShell ||
			showEnergyLevels ||
			(showIonizationEnergies && element.ionizationEnergies != nil) ||
			showQuantumNumbers
	}

	private var thermoDynamicHasVisibleRow: Bool {
		(showMeltingPoint && element.meltingPoint != nil) ||
			(showBoilingPoint && element.boilingPoint != nil) ||
			(showCriticalTemperature && element.criticalTemperature != nil) ||
			(showCriticalPressure && element.criticalPressure != nil) ||
			(showCuriePoint && element.curiePoint != nil) ||
			(showNeelPoint && element.neelPoint != nil) ||
			(showSuperconductingPoint && element.superconductingPoint != nil) ||
			(showHeatSpecific && element.heat?.specific != nil) ||
			(showHeatVaporization && element.heat?.vaporization != nil) ||
			(showHeatFusion && element.heat?.fusion != nil) ||
			(showHeatMolar && element.heat?.molar != nil) ||
			(showAdiabaticIndex && element.adiabaticIndex != nil)
	}

	private var classificationHasVisibleRow: Bool {
		showBlock ||
			showGroupRow ||
			showPeriod ||
			showSeries ||
			showPhase ||
			(showGasPhase && element.gasPhase != nil) ||
			showCasNumber ||
			(showCidNumber && element.classifications.cidNumber != nil) ||
			(showRtecsNumber && element.classifications.rtecsNumber != nil) ||
			(showDotNumbers && element.classifications.dotNumbers != nil) ||
			(showDotHazardClass && element.classifications.dotHazardClass != nil)
	}

	private var mechanicalHasVisibleRow: Bool {
		(showShearModulus && element.density?.shear != nil) ||
			(showYoungModulus && element.density?.young != nil) ||
			(showStandardDensity && element.density?.stp != nil) ||
			(showAtomicIonicRadius && element.hardness?.radius != nil) ||
			(showVickersHardness && element.hardness?.vickers != nil) ||
			(showMohsCalculated && element.hardness?.vickers != nil) ||
			(showMohsMPA && element.hardness?.mohs != nil) ||
			(showSpeedOfSound && element.speedOfSound != nil) ||
			(showMolarVolume && element.molarVolume != nil) ||
			(showRadiusEmpirical && element.radius?.empirical != nil) ||
			(showRadiusCovalent && element.radius?.covalent != nil) ||
			(showRadiusVanderwaals && element.radius?.vanderwaals != nil)
	}

	private var magneticHasVisibleRow: Bool {
		(showMagneticType && element.magneticType != nil) ||
			(showMagneticSusceptibilityMass && element.magneticSusceptibility?.mass != nil) ||
			(showMagneticSusceptibilityMolar && element.magneticSusceptibility?.molar != nil) ||
			(showMagneticSusceptibilityVolume && element.magneticSusceptibility?.volume != nil)
	}

	private var electricalHasVisibleRow: Bool {
		(showElectricalType && element.electricalType != nil) ||
			(showConductivityThermal && element.conductivity?.thermal != nil)
	}

	private var crystalHasVisibleRow: Bool {
		(showCrystalStructure && element.crystalStructure != nil) ||
			(showLatticeAngles && element.latticeAngles != nil) ||
			(showLatticeConstants && element.latticeConstants != nil) ||
			(showSpaceGroupName && element.spaceGroupName != nil) ||
			(showSpaceGroupNumber && element.spaceGroupNumber != nil)
	}

	private var nuclearHasVisibleRow: Bool {
		(showKnownIsotopes && element.isotopesKnown != nil) ||
			(showIsotopicAbundances && element.isotopicAbundances != nil) ||
			(showHalfLife && {
				if case .stable = element.halfLife { return true }
				if case .unstable = element.halfLife { return true }
				return false
			}()) ||
			(showLifetime && {
				if case .unstable = element.lifetime { return true }
				return false
			}()) ||
			(showDecayMode && element.decayMode != nil) ||
			(showNeutronCrossSection && element.neutronCrossSection != nil) ||
			(showNeutronMassAbsorption && element.neutronMassAbsorption != nil)
	}

	private var otherHasVisibleRow: Bool {
		showAbundance ||
			(showRadiusCalculated && element.radius?.calculated != nil) ||
			(showRefractiveIndex && element.refractiveIndex != nil) ||
			(showAllotropes && element.allotropes != nil) ||
			(showOxidationStates && element.oxidationStates != nil) ||
			(showAppearance && element.appearance != nil) ||
			(showCpkHex && element.cpkHex != nil) ||
			(showDiscoveredYear && element.discovered?.year != nil)
	}

	private var infoHasVisibleRow: Bool {
		(showSummary && !element.summary.isEmpty) || (showSourceRow && !element.source.isEmpty)
	}

	var header: some View {
		VStack(spacing: 15) {
			HStack {
				Text(element.symbol)
					.font(.largeTitle)
					.frame(width: 80, height: 80)
					.glassEffect(.clear.tint(element.series.themeColor).interactive())
					.padding(.leading, 10)
					.fontDesign(.monospaced)
					.bold()
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
						.rotationEffect(reduceMotion ? .degrees(0) : .degrees(rotation))
						.onAppear {
							withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
								rotation = 360
							}
						}
				}
			}
		}
		.padding(.vertical)
		.accessibilityLabel("Electron diagram for \(element.name), showing electrons in shells")
		.accessibilityHint("Visual representation only, not interactive")
		.accessibilityHidden(true)
		.accessibilityElement(children: .ignore)
	}

	var atomicStructure: some View {
		VStack(spacing: 20) {
			if showAtomicMass {
				LeftRight {
					Text("Relative Atomic Mass")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", element.atomicMass) + " amu")
						.fontDesign(.monospaced)
				}
			}

			if showValenceElectrons, let valenceElectrons = element.valenceElectrons {
				LeftRight {
					Text("Valence Electrons")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(valenceElectrons.description)
						.fontDesign(.monospaced)
				}
			}

			if showElectronAffinity, let electronAffinity = element.electronAffinity {
				LeftRight {
					Text("Electron Affinity")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(String(format: "%.3f", electronAffinity) + " kJ/mol")
						.fontDesign(.monospaced)
				}
			}

			if showElectronConfiguration {
				LeftRight {
					Text("Electron Configuration")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(element.electronConfiguration)
						.fontDesign(.monospaced)
				}
			}

			if showElectronConfigurationSemantic {
				LeftRight {
					Text("Electron Config (Semantic)")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(element.electronConfigurationSemantic)
						.fontDesign(.monospaced)
				}
			}

			if showElectronegativityPauling, let electronegativity = element.electronegativityPauling {
				LeftRight {
					Text("Electronegativity (Pauling)")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(String(format: "%.2f", electronegativity))
						.fontDesign(.monospaced)
				}
			}

			if showElectronsPerShell {
				LeftRight {
					Text("Electrons Per Shell")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(element.electronsPerShell.map(String.init).joined(separator: ", "))
						.fontDesign(.monospaced)
				}
			}

			if showEnergyLevels {
				LeftRight {
					Text("Energy Levels")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(element.energyLevels)
						.fontDesign(.monospaced)
				}
			}

			if showIonizationEnergies, let ionizationEnergies = element.ionizationEnergies {
				LeftRight {
					Text("Ionization Energies")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					VStack(alignment: .trailing) {
						ForEach(Array(ionizationEnergies.prefix(5).enumerated()), id: \.offset) { index, energy in
							Text("\(index + 1): \(String(format: "%.1f", energy)) kJ/mol")
								.fontDesign(.monospaced)
								.font(.caption2)
						}
						if ionizationEnergies.count > 5 {
							Text("... +\(ionizationEnergies.count - 5) more")
								.font(.caption2)
								.foregroundStyle(.secondary)
						}
					}
				}
			}

			if showQuantumNumbers {
				LeftRight {
					Text("Quantum Numbers")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(element.quantumNumbers)
						.fontDesign(.monospaced)
				}
			}
		}
	}

	var thermoDynamic: some View {
		VStack(spacing: 20) {
			if showMeltingPoint, let meltingPoint = element.meltingPoint {
				LeftRight {
					Text("Melting Point")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", meltingPoint) + " °K")
						.fontDesign(.monospaced)
				}
			}

			if showBoilingPoint, let boilingPoint = element.boilingPoint {
				LeftRight {
					Text("Boiling Point")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", boilingPoint) + " °K")
						.fontDesign(.monospaced)
				}
			}

			if showCriticalTemperature, let criticalTemperature = element.criticalTemperature {
				LeftRight {
					Text("Critical Temperature")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", criticalTemperature) + " °K")
						.fontDesign(.monospaced)
				}
			}

			if showCriticalPressure, let criticalPressure = element.criticalPressure {
				LeftRight {
					Text("Critical Pressure")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", criticalPressure) + " MPa")
						.fontDesign(.monospaced)
				}
			}

			if showCuriePoint, let curiePoint = element.curiePoint {
				LeftRight {
					Text("Curie Point")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", curiePoint) + " °K")
						.fontDesign(.monospaced)
				}
			}

			if showNeelPoint, let neelPoint = element.neelPoint {
				LeftRight {
					Text("Neel Point")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", neelPoint) + " °K")
						.fontDesign(.monospaced)
				}
			}

			if showSuperconductingPoint, let superconductingPoint = element.superconductingPoint {
				LeftRight {
					Text("Superconducting Point")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", superconductingPoint) + " °K")
						.fontDesign(.monospaced)
				}
			}

			if let heat = element.heat {
				if showHeatSpecific, let specific = heat.specific {
					LeftRight {
						Text("Heat - Specific")
							.font(.caption)
							.foregroundStyle(.tertiary)
					} right: {
						Text(String(format: "%.3f", specific) + " J/(g·K)")
							.fontDesign(.monospaced)
					}
				}

				if showHeatVaporization, let vaporization = heat.vaporization {
					LeftRight {
						Text("Heat - Vaporization")
							.font(.caption)
							.foregroundStyle(.tertiary)
					} right: {
						Text(String(format: "%.3f", vaporization) + " kJ/mol")
							.fontDesign(.monospaced)
					}
				}

				if showHeatFusion, let fusion = heat.fusion {
					LeftRight {
						Text("Heat - Fusion")
							.font(.caption)
							.foregroundStyle(.tertiary)
					} right: {
						Text(String(format: "%.3f", fusion) + " kJ/mol")
							.fontDesign(.monospaced)
					}
				}

				if showHeatMolar, let molar = heat.molar {
					LeftRight {
						Text("Heat - Molar")
							.font(.caption)
							.foregroundStyle(.tertiary)
					} right: {
						Text(String(format: "%.3f", molar) + " J/(mol·K)")
							.fontDesign(.monospaced)
					}
				}
			}

			if showAdiabaticIndex, let adiabaticIndex = element.adiabaticIndex {
				LeftRight {
					Text("Adiabatic Index")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(adiabaticIndex)
						.fontDesign(.monospaced)
				}
			}
		}
	}

	var classification: some View {
		VStack(spacing: 20) {
			if showBlock {
				LeftRight {
					Text("Block")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(element.block.name)
						.fontDesign(.monospaced)
				}
			}

			if showGroupRow {
				LeftRight {
					Text("Group")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(element.group.description)
						.fontDesign(.monospaced)
				}
			}

			if showPeriod {
				LeftRight {
					Text("Period")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(element.period.description)
						.fontDesign(.monospaced)
				}
			}

			if showSeries {
				LeftRight {
					Text("Series")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(element.series.rawValue.capitalized)
						.fontDesign(.monospaced)
				}
			}

			if showPhase {
				LeftRight {
					Text("Phase")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(element.phase.rawValue)
						.fontDesign(.monospaced)
				}
			}

			if showGasPhase, let gasPhase = element.gasPhase {
				LeftRight {
					Text("Gas Phase")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(gasPhase.rawValue)
						.fontDesign(.monospaced)
				}
			}

			if showCasNumber {
				LeftRight {
					Text("CAS Number")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(element.classifications.casNumber)
						.fontDesign(.monospaced)
				}
			}

			if showCidNumber, let cidNumber = element.classifications.cidNumber {
				LeftRight {
					Text("CID Number")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(cidNumber)
						.fontDesign(.monospaced)
				}
			}

			if showRtecsNumber, let rtecsNumber = element.classifications.rtecsNumber {
				LeftRight {
					Text("RTECS Number")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(rtecsNumber)
						.fontDesign(.monospaced)
				}
			}

			if showDotNumbers, let dotNumbers = element.classifications.dotNumbers {
				LeftRight {
					Text("DOT Numbers")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(dotNumbers.description)
						.fontDesign(.monospaced)
				}
			}

			if showDotHazardClass, let dotHazardClass = element.classifications.dotHazardClass {
				LeftRight {
					Text("DOT Hazard Class")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(String(format: "%.1f", dotHazardClass))
						.fontDesign(.monospaced)
				}
			}
		}
	}

	var mechanical: some View {
		VStack(spacing: 20) {
			if let density = element.density {
				if showShearModulus, let shear = density.shear {
					LeftRight {
						Text("Shear modulus")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", shear) + " GPa")
							.fontDesign(.monospaced)
					}
				}

				if showYoungModulus, let young = density.young {
					LeftRight {
						Text("Young modulus")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", young) + " GPa")
							.fontDesign(.monospaced)
					}
				}

				if showStandardDensity, let stp = density.stp {
					LeftRight {
						Text("Standard density")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", stp) + " kg/m³")
							.fontDesign(.monospaced)
					}
				}
			}

			if let hardness = element.hardness {
				if showAtomicIonicRadius, let radius = hardness.radius {
					LeftRight {
						Text("Atomic/ionic radius hardness")
							.font(.caption)
							.foregroundStyle(.tertiary)
					} right: {
						Text(String(format: "%.1f", radius) + " pm")
							.fontDesign(.monospaced)
					}
				}

				if showVickersHardness, let vickers = hardness.vickers {
					LeftRight {
						Text("Vickers hardness")
							.font(.caption)
							.foregroundStyle(.tertiary)
					} right: {
						Text(String(format: "%.3f", vickers) + " MPa")
							.fontDesign(.monospaced)
					}

					// Compute Mohs 1-10 from Vickers
					let mohsValue = switch vickers {
						case 0 ..< 60: 1
						case 60 ..< 120: 2
						case 120 ..< 200: 3
						case 200 ..< 400: 4
						case 400 ..< 500: 5
						case 500 ..< 700: 6
						case 700 ..< 1000: 7
						case 1000 ..< 1200: 8
						case 1200 ..< 1400: 9
						default: 10
					}

					if showMohsCalculated {
						LeftRight {
							Text("Mohs (1–10)")
								.font(.caption)
								.foregroundStyle(.tertiary)
						} right: {
							Text(mohsValue.description)
								.fontDesign(.monospaced)
						}
					}
				}

				if showMohsMPA, let mohs = hardness.mohs {
					LeftRight {
						Text("Mohs hardness (MPa)")
							.font(.caption)
							.foregroundStyle(.tertiary)
					} right: {
						Text(String(format: "%.3f", mohs) + " MPa")
							.fontDesign(.monospaced)
					}
				}
			}

			if showSpeedOfSound, let sos = element.speedOfSound {
				LeftRight {
					Text("Speed of sound")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(String(format: "%.3f", sos) + " m/s")
						.fontDesign(.monospaced)
				}
			}

			if showMolarVolume, let molarVolume = element.molarVolume {
				LeftRight {
					Text("Molar Volume")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(String(format: "%.6f", molarVolume) + " m³/mol")
						.fontDesign(.monospaced)
				}
			}

			if let radius = element.radius {
				if showRadiusEmpirical, let empirical = radius.empirical {
					LeftRight {
						Text("Radius - Empirical")
							.font(.caption)
							.foregroundStyle(.tertiary)
					} right: {
						Text(String(format: "%.1f", empirical) + " pm")
							.fontDesign(.monospaced)
					}
				}

				if showRadiusCovalent, let covalent = radius.covalent {
					LeftRight {
						Text("Radius - Covalent")
							.font(.caption)
							.foregroundStyle(.tertiary)
					} right: {
						Text(String(format: "%.1f", covalent) + " pm")
							.fontDesign(.monospaced)
					}
				}

				if showRadiusVanderwaals, let vanderwaals = radius.vanderwaals {
					LeftRight {
						Text("Radius - Van der Waals")
							.font(.caption)
							.foregroundStyle(.tertiary)
					} right: {
						Text(String(format: "%.1f", vanderwaals) + " pm")
							.fontDesign(.monospaced)
					}
				}
			}
		}
	}

	var magnetic: some View {
		VStack(spacing: 20) {
			if showMagneticType, let magneticType = element.magneticType {
				LeftRight {
					Text("Magnetic Type")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(magneticType.rawValue.capitalized)
						.fontDesign(.monospaced)
				}
			}

			if let susceptibility = element.magneticSusceptibility {
				if showMagneticSusceptibilityMass {
					LeftRight {
						Text("Magnetic Susceptibility (Mass)")
							.font(.caption)
							.foregroundStyle(.tertiary)
					} right: {
						Text(String(format: "%.3e", susceptibility.mass) + " m³/kg")
							.fontDesign(.monospaced)
					}
				}

				if showMagneticSusceptibilityMolar {
					LeftRight {
						Text("Magnetic Susceptibility (Molar)")
							.font(.caption)
							.foregroundStyle(.tertiary)
					} right: {
						Text(String(format: "%.3e", susceptibility.molar) + " m³/mol")
							.fontDesign(.monospaced)
					}
				}

				if showMagneticSusceptibilityVolume {
					LeftRight {
						Text("Magnetic Susceptibility (Volume)")
							.font(.caption)
							.foregroundStyle(.tertiary)
					} right: {
						Text(String(format: "%.6e", susceptibility.volume))
							.fontDesign(.monospaced)
					}
				}
			}
		}
	}

	var electrical: some View {
		VStack(spacing: 20) {
			if showElectricalType, let electricalType = element.electricalType {
				LeftRight {
					Text("Electrical Type")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(electricalType.rawValue.capitalized)
						.fontDesign(.monospaced)
				}
			}

			if showConductivityThermal, let conductivity = element.conductivity, conductivity.thermal > 0 {
				LeftRight {
					Text("Thermal Conductivity")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(String(format: "%.3f", conductivity.thermal) + " W/(m·K)")
						.fontDesign(.monospaced)
				}
			}
		}
	}

	var crystal: some View {
		VStack(spacing: 20) {
			if showCrystalStructure, let crystalStructure = element.crystalStructure {
				LeftRight {
					Text("Crystal Structure")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(crystalStructure.name)
						.fontDesign(.monospaced)
				}
			}

			if showLatticeAngles, let latticeAngles = element.latticeAngles {
				LeftRight {
					Text("Lattice Angles")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(latticeAngles)
						.fontDesign(.monospaced)
				}
			}

			if showLatticeConstants, let latticeConstants = element.latticeConstants {
				LeftRight {
					Text("Lattice Constants")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(latticeConstants)
						.fontDesign(.monospaced)
				}
			}

			if showSpaceGroupName, let spaceGroupName = element.spaceGroupName {
				LeftRight {
					Text("Space Group Name")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(spaceGroupName)
						.fontDesign(.monospaced)
				}
			}

			if showSpaceGroupNumber, let spaceGroupNumber = element.spaceGroupNumber {
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
			if showKnownIsotopes, let isotopesKnown = element.isotopesKnown {
				LeftRight {
					Text("Known Isotopes")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(isotopesKnown)
						.fontDesign(.monospaced)
				}
			}

			if showIsotopicAbundances, let isotopicAbundances = element.isotopicAbundances {
				LeftRight {
					Text("Isotope Abundances")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(isotopicAbundances)
						.fontDesign(.monospaced)
				}
			}

			if showHalfLife {
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
			}

			if showLifetime {
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
			}

			if showDecayMode, let decayMode = element.decayMode {
				LeftRight {
					Text("Decay Type")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(decayMode.name)
						.fontDesign(.monospaced)
				}
			}

			if showNeutronCrossSection, let neutronCrossSection = element.neutronCrossSection {
				LeftRight {
					Text("Neutron Cross Section")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(String(format: "%.3f", neutronCrossSection) + " barns")
						.fontDesign(.monospaced)
				}
			}

			if showNeutronMassAbsorption, let neutronMassAbsorption = element.neutronMassAbsorption {
				LeftRight {
					Text("Neutron Mass Absorption")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(String(format: "%.5f", neutronMassAbsorption))
						.fontDesign(.monospaced)
				}
			}
		}
	}

	var other: some View {
		VStack(spacing: 20) {
			if showAbundance {
				LeftRight {
					Text("Abundance")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Group {
						if element.abundance.isSynthetic {
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
			}

			if let radius = element.radius {
				if showRadiusCalculated, let calculated = radius.calculated {
					LeftRight {
						Text("Calculated Radius")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.1f", calculated) + " pm")
							.fontDesign(.monospaced)
					}
				}
			}

			if showRefractiveIndex, let refractiveIndex = element.refractiveIndex {
				LeftRight {
					Text("Refractive Index")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.6f", refractiveIndex))
						.fontDesign(.monospaced)
				}
			}

			if showAllotropes, let allotropes = element.allotropes {
				LeftRight {
					Text("Allotropes")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(allotropes)
						.fontDesign(.monospaced)
				}
			}

			if showOxidationStates, let oxidationStates = element.oxidationStates {
				LeftRight {
					Text("Oxidation States")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(oxidationStates)
						.fontDesign(.monospaced)
				}
			}

			if showAppearance, let appearance = element.appearance {
				LeftRight {
					Text("Appearance")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(appearance.capitalized)
						.fontDesign(.monospaced)
				}
			}

			if showCpkHex, let cpkHex = element.cpkHex {
				LeftRight {
					Text("CPK Hex Color")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					HStack(spacing: 8) {
						Text("#" + cpkHex.uppercased())
							.fontDesign(.monospaced)
						Circle()
							.fill(Color(hex: cpkHex))
							.frame(width: 20, height: 20)
							.overlay(Circle().stroke(Color.primary.opacity(0.2), lineWidth: 1))
					}
				}
			}

			if showDiscoveredYear, let discovered = element.discovered {
				LeftRight {
					Text("Discovered")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(discovered.year.description)
						.fontDesign(.monospaced)
				}
			}
		}
	}

	var info: some View {
		VStack(alignment: .leading) {
			if showSummary {
				Text(element.summary)
					.padding(.bottom, 20)
					.fontDesign(.serif)
					.textSelection(.enabled)
			}

			if showSourceRow {
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
		}
		.padding(15)
		.background(.ultraThinMaterial)
		.clipShape(RoundedRectangle(cornerRadius: 20))
	}
}

extension Color {
	init(hex: String) {
		let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
		var int: UInt64 = 0
		Scanner(string: hex).scanHexInt64(&int)
		let a, r, g, b: UInt64
		switch hex.count {
			case 3: // RGB (12-bit)
				(a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
			case 6: // RGB (24-bit)
				(a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
			case 8: // ARGB (32-bit)
				(a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
			default:
				(a, r, g, b) = (255, 0, 0, 0)
		}
		self.init(
			.sRGB,
			red: Double(r) / 255,
			green: Double(g) / 255,
			blue: Double(b) / 255,
			opacity: Double(a) / 255
		)
	}
}
