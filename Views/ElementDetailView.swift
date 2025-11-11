//
//  ElementDetailView.swift
//  Elements
//
//  Created by Adon Omeri on 8/11/2025.
//

import SwiftUI

struct ElementDetailView: View {
	@Environment(\.dismiss) private var dismiss
	let element: Element
	@State private var rotation = 0.0

	@State var isCopied = false

	// Section-level toggles
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

	// Atomic Structure rows
	@AppStorage("show_atomic_mass") private var showAtomicMass: Bool = true
	@AppStorage("show_valence_electrons") private var showValenceElectrons: Bool = true
	@AppStorage("show_electron_configuration") private var showElectronConfiguration: Bool = true
	@AppStorage("show_electron_configuration_semantic") private var showElectronConfigurationSemantic: Bool = true
	@AppStorage("show_quantum_numbers") private var showQuantumNumbers: Bool = true
	@AppStorage("show_oxidation_states") private var showOxidationStates: Bool = true

	// Thermo rows
	@AppStorage("show_melting_point") private var showMeltingPoint: Bool = true
	@AppStorage("show_boiling_point") private var showBoilingPoint: Bool = true
	@AppStorage("show_critical_temperature") private var showCriticalTemperature: Bool = true
	@AppStorage("show_critical_pressure") private var showCriticalPressure: Bool = true
	@AppStorage("show_curie_point") private var showCuriePoint: Bool = true
	@AppStorage("show_neel_point") private var showNeelPoint: Bool = true
	@AppStorage("show_superconducting_point") private var showSuperconductingPoint: Bool = true
	@AppStorage("show_thermal_expansion") private var showThermalExpansion: Bool = true
	@AppStorage("show_specific_heat") private var showSpecificHeat: Bool = true
	@AppStorage("show_heat_of_fusion") private var showHeatOfFusion: Bool = true
	@AppStorage("show_heat_of_vaporization") private var showHeatOfVaporization: Bool = true
	@AppStorage("show_molar_heat_capacity") private var showMolarHeatCapacity: Bool = true

	// Classification rows
	@AppStorage("show_block") private var showBlock: Bool = true
	@AppStorage("show_group") private var showGroupRow: Bool = true
	@AppStorage("show_period") private var showPeriod: Bool = true
	@AppStorage("show_cas_number") private var showCasNumber: Bool = true
	@AppStorage("show_cid_number") private var showCidNumber: Bool = true
	@AppStorage("show_rtecs_number") private var showRtecsNumber: Bool = true
	@AppStorage("show_dot_numbers") private var showDotNumbers: Bool = true
	@AppStorage("show_dot_hazard_class") private var showDotHazardClass: Bool = true

	// Mechanical rows
	@AppStorage("show_shear_modulus") private var showShearModulus: Bool = true
	@AppStorage("show_young_modulus") private var showYoungModulus: Bool = true
	@AppStorage("show_standard_density") private var showStandardDensity: Bool = true
	@AppStorage("show_liquid_density") private var showLiquidDensity: Bool = true
	@AppStorage("show_atomic_ionic_radius") private var showAtomicIonicRadius: Bool = true
	@AppStorage("show_vickers_hardness") private var showVickersHardness: Bool = true
	@AppStorage("show_mohs_calculated") private var showMohsCalculated: Bool = true
	@AppStorage("show_mohs_mpa") private var showMohsMPA: Bool = true
	@AppStorage("show_brinell_hardness") private var showBrinellHardness: Bool = true
	@AppStorage("show_bulk_modulus") private var showBulkModulus: Bool = true
	@AppStorage("show_poisson_ratio") private var showPoissonRatio: Bool = true
	@AppStorage("show_speed_of_sound") private var showSpeedOfSound: Bool = true

	// Magnetic rows
	@AppStorage("show_magnetic_type") private var showMagneticType: Bool = true
	@AppStorage("show_magnetic_susceptibility_mass") private var showMagSusMass: Bool = true
	@AppStorage("show_magnetic_susceptibility_molar") private var showMagSusMolar: Bool = true
	@AppStorage("show_magnetic_susceptibility_volume") private var showMagSusVolume: Bool = true

	// Electrical rows
	@AppStorage("show_thermal_conductivity") private var showThermalConductivity: Bool = true
	@AppStorage("show_electrical_conductivity") private var showElectricalConductivity: Bool = true
	@AppStorage("show_resistivity") private var showResistivity: Bool = true
	@AppStorage("show_electrical_type") private var showElectricalType: Bool = true
	@AppStorage("show_electron_affinity") private var showElectronAffinity: Bool = true
	@AppStorage("show_electronegativity_pauling") private var showElectronegativityPauling: Bool = true
	@AppStorage("show_ionization_energies") private var showIonizationEnergies: Bool = true

	// Crystal rows
	@AppStorage("show_crystal_structure") private var showCrystalStructure: Bool = true
	@AppStorage("show_lattice_angles") private var showLatticeAngles: Bool = true
	@AppStorage("show_lattice_constants") private var showLatticeConstants: Bool = true
	@AppStorage("show_space_group_name") private var showSpaceGroupName: Bool = true
	@AppStorage("show_space_group_number") private var showSpaceGroupNumber: Bool = true

	// Nuclear rows
	@AppStorage("show_known_isotopes") private var showKnownIsotopes: Bool = true
	@AppStorage("show_isotopic_abundances") private var showIsotopicAbundances: Bool = true
	@AppStorage("show_half_life") private var showHalfLife: Bool = true
	@AppStorage("show_lifetime") private var showLifetime: Bool = true
	@AppStorage("show_decay_mode") private var showDecayMode: Bool = true
	@AppStorage("show_neutron_cross_section") private var showNeutronCrossSection: Bool = true
	@AppStorage("show_neutron_mass_absorption") private var showNeutronMassAbsorption: Bool = true

	// Other rows
	@AppStorage("show_abundance") private var showAbundance: Bool = true
	@AppStorage("show_adiabatic_index") private var showAdiabaticIndex: Bool = true
	@AppStorage("show_energy_levels") private var showEnergyLevels: Bool = true
	@AppStorage("show_gas_phase") private var showGasPhase: Bool = true
	@AppStorage("show_molar_volume") private var showMolarVolume: Bool = true
	@AppStorage("show_radius_calculated") private var showRadiusCalculated: Bool = true
	@AppStorage("show_radius_empirical") private var showRadiusEmpirical: Bool = true
	@AppStorage("show_radius_covalent") private var showRadiusCovalent: Bool = true
	@AppStorage("show_radius_vanderwaals") private var showRadiusVanderwaals: Bool = true
	@AppStorage("show_refractive_index") private var showRefractiveIndex: Bool = true
	@AppStorage("show_allotropes") private var showAllotropes: Bool = true

	// Info rows
	@AppStorage("show_summary") private var showSummary: Bool = true
	@AppStorage("show_source") private var showSourceRow: Bool = true

	var body: some View {
		NavigationStack {
			GeometryReader { geometry in
				ScrollView(.vertical) {
					VStack(alignment: .center, spacing: 30) {
						// Header always shown
						header

						// Build visible sections and place dividers correctly
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
				.scrollIndicatorsFlash(onAppear: true)
				.toolbar {
					ToolbarItem(placement: .topBarTrailing) {
						Button(role: .close) {
							dismiss()
						}
					}

					ToolbarItem(placement: .title) {
						Text(element.name)
							.monospaced()
					}

					ToolbarItem(placement: .status) {
						Button {
							UIPasteboard.general.string = element.name
							isCopied = true
						} label: {
							Group {
								if !isCopied {
									Label("Copy", systemImage: "document.on.document")
										.animation(.easeInOut, value: isCopied)
								} else {
									Label("Copied", systemImage: "checkmark")
										.animation(.easeInOut, value: isCopied)
								}
							}
							.transition(.blurReplace)
						}
					}
				}
				.frame(width: geometry.size.width)
			}
		}
	}

	// MARK: - Build visible sections array (only put sections with content)

	private func visibleSectionViews() -> [AnyView] {
		var result: [AnyView] = []

		// shells
		if showSectionShells {
			// shells has content (no per-row toggles inside it)
			result.append(AnyView(shells))
		}

		// atomic
		if showSectionAtomic && atomicStructureHasVisibleRow {
			result.append(AnyView(atomicStructure))
		}

		// thermo
		if showSectionThermo && thermoDynamicHasVisibleRow {
			result.append(AnyView(thermoDynamic))
		}

		// classification
		if showSectionClassification && classificationHasVisibleRow {
			result.append(AnyView(classification))
		}

		// mechanical
		if showSectionMechanical && mechanicalHasVisibleRow {
			result.append(AnyView(mechanical))
		}

		// magnetic
		if showSectionMagnetic && magneticHasVisibleRow {
			result.append(AnyView(magnetic))
		}

		// electrical
		if showSectionElectrical && electricalHasVisibleRow {
			result.append(AnyView(electrical))
		}

		// crystal
		if showSectionCrystal && crystalHasVisibleRow {
			result.append(AnyView(crystal))
		}

		// nuclear
		if showSectionNuclear && nuclearHasVisibleRow {
			result.append(AnyView(nuclear))
		}

		// other
		if showSectionOther && otherHasVisibleRow {
			result.append(AnyView(other))
		}

		// info
		if showSectionInfo && infoHasVisibleRow {
			result.append(AnyView(info))
		}

		return result
	}

	// MARK: - Section visibility checks (ensure at least one row exists & is allowed)

	private var atomicStructureHasVisibleRow: Bool {
		return showAtomicMass ||
			(showValenceElectrons && element.valenceElectrons != nil) ||
			showElectronConfiguration ||
			showElectronConfigurationSemantic ||
			showQuantumNumbers ||
			(showOxidationStates && element.oxidationStates != nil)
	}

	private var thermoDynamicHasVisibleRow: Bool {
		return (showMeltingPoint && element.meltingPoint != nil) ||
			(showBoilingPoint && element.boilingPoint != nil) ||
			(showCriticalTemperature && element.criticalTemperature != nil) ||
			(showCriticalPressure && element.criticalPressure != nil) ||
			(showCuriePoint && element.curiePoint != nil) ||
			(showNeelPoint && element.neelPoint != nil) ||
			(showSuperconductingPoint && element.superconductingPoint != nil) ||
			(showThermalExpansion && element.thermalExpansion != nil) ||
			(showSpecificHeat && element.heat?.specific != nil) ||
			(showHeatOfFusion && element.heat?.fusion != nil) ||
			(showHeatOfVaporization && element.heat?.vaporization != nil) ||
			(showMolarHeatCapacity && element.heat?.molar != nil)
	}

	private var classificationHasVisibleRow: Bool {
		return showBlock ||
			showGroupRow ||
			showPeriod ||
			showCasNumber ||
			(showCidNumber && element.classifications.cidNumber != nil) ||
			(showRtecsNumber && element.classifications.rtecsNumber != nil) ||
			(showDotNumbers && element.classifications.dotNumbers != nil) ||
			(showDotHazardClass && element.classifications.dotHazardClass != nil)
	}

	private var mechanicalHasVisibleRow: Bool {
		return (showShearModulus && element.density?.shear != nil) ||
			(showYoungModulus && element.density?.young != nil) ||
			(showStandardDensity && element.density?.stp != nil) ||
			(showLiquidDensity && element.density?.liquid != nil) ||
			(showAtomicIonicRadius && element.hardness?.radius != nil) ||
			(showVickersHardness && element.hardness?.vickers != nil) ||
			(showMohsCalculated && element.hardness?.vickers != nil) ||
			(showMohsMPA && element.hardness?.mohs != nil) ||
			(showBrinellHardness && element.hardness?.brinell != nil) ||
			(showBulkModulus && element.modulus?.bulk != nil) ||
			(showPoissonRatio && element.poissonRatio != nil) ||
			(showSpeedOfSound && element.speedOfSound != nil)
	}

	private var magneticHasVisibleRow: Bool {
		return (showMagneticType && element.magneticType != nil) ||
			(showMagSusMass && element.magneticSusceptibility?.mass != nil) ||
			(showMagSusMolar && element.magneticSusceptibility?.molar != nil) ||
			(showMagSusVolume && element.magneticSusceptibility?.volume != nil)
	}

	private var electricalHasVisibleRow: Bool {
		return (showThermalConductivity && element.conductivity != nil) ||
			(showElectricalConductivity && element.conductivity != nil) ||
			(showResistivity && element.resistivity != nil) ||
			(showElectricalType && element.electricalType != nil) ||
			(showElectronAffinity && element.electronAffinity != nil) ||
			(showElectronegativityPauling && element.electronegativityPauling != nil) ||
			(showIonizationEnergies && element.ionizationEnergies != nil)
	}

	private var crystalHasVisibleRow: Bool {
		return (showCrystalStructure && element.crystalStructure != nil) ||
			(showLatticeAngles && element.latticeAngles != nil) ||
			(showLatticeConstants && element.latticeConstants != nil) ||
			(showSpaceGroupName && element.spaceGroupName != nil) ||
			(showSpaceGroupNumber && element.spaceGroupNumber != nil)
	}

	private var nuclearHasVisibleRow: Bool {
		return (showKnownIsotopes && element.isotopesKnown != nil) ||
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
		// abundance always exists as enum; but hide if user disabled
		return showAbundance ||
			(showAdiabaticIndex && element.adiabaticIndex != nil) ||
			showEnergyLevels ||
			(showGasPhase && element.gasPhase != nil) ||
			(showMolarVolume && element.molarVolume != nil) ||
			(showRadiusCalculated && element.radius?.calculated != nil) ||
			(showRadiusEmpirical && element.radius?.empirical != nil) ||
			(showRadiusCovalent && element.radius?.covalent != nil) ||
			(showRadiusVanderwaals && element.radius?.vanderwaals != nil) ||
			(showRefractiveIndex && element.refractiveIndex != nil) ||
			(showAllotropes && element.allotropes != nil)
	}

	private var infoHasVisibleRow: Bool {
		return (showSummary && !element.summary.isEmpty) || (showSourceRow && !element.source.isEmpty)
	}

	// MARK: - The original subviews (rows inside are gated by their @AppStorage flags)

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
			if showAtomicMass {
				LeftRight {
					Text("Atomic Mass")
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
					Text("Semantic Electron Configuration")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(element.electronConfigurationSemantic)
						.fontDesign(.monospaced)
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
					Text(String(format: "%.3f", criticalPressure) + " °K")
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

			if showThermalExpansion, let thermalExpansion = element.thermalExpansion {
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
				if showSpecificHeat, let specific = heat.specific {
					LeftRight {
						Text("Specific Heat")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", specific) + " J/(kg K)")
							.fontDesign(.monospaced)
					}
				}

				if showHeatOfFusion, let fusion = heat.fusion {
					LeftRight {
						Text("Heat of Fusion")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", fusion) + " kJ/mol")
							.fontDesign(.monospaced)
					}
				}
				if showHeatOfVaporization, let vaporization = heat.vaporization {
					LeftRight {
						Text("Heat of vaporization")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", vaporization) + " kJ/mol")
							.fontDesign(.monospaced)
					}
				}

				if showMolarHeatCapacity, let molar = heat.molar {
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
					Text("DOT Number")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(dotNumbers.description)
						.fontDesign(.monospaced)
				}
			}

			if showDotHazardClass, let dotHazardClass = element.classifications.dotHazardClass {
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

				if showLiquidDensity, let liquid = density.liquid {
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

				if showBrinellHardness, let brinell = hardness.brinell {
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

			if let modulus = element.modulus, let bulk = modulus.bulk, showBulkModulus {
				LeftRight {
					Text("Bulk modulus")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(String(format: "%.3f", bulk) + " GPa")
						.fontDesign(.monospaced)
				}
			}

			if showPoissonRatio, let poisson = element.poissonRatio {
				LeftRight {
					Text("Poisson ratio")
						.font(.caption)
						.foregroundStyle(.tertiary)
				} right: {
					Text(String(format: "%.3f", poisson))
						.fontDesign(.monospaced)
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
					Text(magneticType.rawValue)
						.fontDesign(.monospaced)
				}
			}

			if let magneticSusceptibility = element.magneticSusceptibility {
				if showMagSusMass {
					LeftRight {
						Text("Magnetic Susceptibility - Mass")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", magneticSusceptibility.mass) + " m³/Kg")
							.fontDesign(.monospaced)
					}
				}

				if showMagSusMolar {
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
				}

				if showMagSusVolume {
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
	}

	var electrical: some View {
		VStack(spacing: 20) {
			if let conductivity = element.conductivity {
				if showThermalConductivity {
					LeftRight {
						Text("Thermal Conductivity")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", conductivity.thermal))
							.fontDesign(.monospaced)
					}
				}

				if showElectricalConductivity {
					LeftRight {
						Text("Electrical Conductivity")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", conductivity.electric))
							.fontDesign(.monospaced)
					}
				}
			}

			if showResistivity, let resistivity = element.resistivity {
				LeftRight {
					Text("Thermal Conductivity")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", resistivity) + " m Ω")
						.fontDesign(.monospaced)
				}
			}

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
			if showElectronegativityPauling, let electronegativityPauling = element.electronegativityPauling {
				LeftRight {
					Text("Pauling Electronegativity")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", electronegativityPauling) + " kJ/mol")
						.fontDesign(.monospaced)
				}
			}

			if showIonizationEnergies, let ionizationEnergies = element.ionizationEnergies {
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
					Text(String(format: "%.3f", neutronCrossSection))
						.fontDesign(.monospaced)
				}
			}

			if showNeutronMassAbsorption, let neutronMassAbsorption = element.neutronMassAbsorption {
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
			if showAbundance {
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

			if showGasPhase, let gasPhase = element.gasPhase {
				LeftRight {
					Text("Gas Phase")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(gasPhase.rawValue.capitalized)
						.fontDesign(.monospaced)
				}
			}

			if showMolarVolume, let molarVolume = element.molarVolume {
				LeftRight {
					Text("Molar Volume")
						.font(.caption)
						.foregroundStyle(.tertiary)

				} right: {
					Text(String(format: "%.3f", molarVolume) + " cm³/mol")
						.fontDesign(.monospaced)
				}
			}

			if let radius = element.radius {
				if showRadiusCalculated, let calculated = radius.calculated {
					LeftRight {
						Text("Calculated Radius")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.4f", calculated) + " pm")
							.fontDesign(.monospaced)
					}
				}

				if showRadiusEmpirical, let empirical = radius.empirical {
					LeftRight {
						Text("Empirical Radius")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.4f", empirical) + " pm")
							.fontDesign(.monospaced)
					}
				}

				if showRadiusCovalent, let covalent = radius.covalent {
					LeftRight {
						Text("Covalent Radius")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.4f", covalent) + " pm")
							.fontDesign(.monospaced)
					}
				}

				if showRadiusVanderwaals, let vanderwaals = radius.vanderwaals {
					LeftRight {
						Text("Vanderwaals Radius")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.4f", vanderwaals) + " pm")
							.fontDesign(.monospaced)
					}
				}

				if showRefractiveIndex, let refractiveIndex = element.refractiveIndex {
					LeftRight {
						Text("Refractive Index")
							.font(.caption)
							.foregroundStyle(.tertiary)

					} right: {
						Text(String(format: "%.3f", refractiveIndex))
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
