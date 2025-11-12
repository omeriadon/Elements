//
//  SettingsView.swift
//  Elements
//
//  Created by Adon Omeri on 11/11/2025.
//

import SwiftUI

struct RowSetting: Identifiable {
	let id: String
	let name: String
	var binding: Binding<Bool>

	init(name: String, binding: Binding<Bool>) {
		id = name
		self.name = name
		self.binding = binding
	}
}

struct SectionSetting: Identifiable {
	let id: String
	let header: String
	var sectionBinding: Binding<Bool>?
	var rows: [RowSetting]

	init(header: String, sectionBinding: Binding<Bool>? = nil, rows: [RowSetting] = []) {
		id = header
		self.header = header
		self.sectionBinding = sectionBinding
		self.rows = rows
	}
}

struct SettingsView: View {
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

	@AppStorage("show_atomic_mass") private var showAtomicMass: Bool = true
	@AppStorage("show_valence_electrons") private var showValenceElectrons: Bool = true
	@AppStorage("show_electron_configuration") private var showElectronConfiguration: Bool = true
	@AppStorage("show_electron_configuration_semantic") private var showElectronConfigurationSemantic: Bool = true
	@AppStorage("show_quantum_numbers") private var showQuantumNumbers: Bool = true
	@AppStorage("show_oxidation_states") private var showOxidationStates: Bool = true

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

	@AppStorage("show_block") private var showBlock: Bool = true
	@AppStorage("show_group") private var showGroupRow: Bool = true
	@AppStorage("show_period") private var showPeriod: Bool = true
	@AppStorage("show_cas_number") private var showCasNumber: Bool = true
	@AppStorage("show_cid_number") private var showCidNumber: Bool = true
	@AppStorage("show_rtecs_number") private var showRtecsNumber: Bool = true
	@AppStorage("show_dot_numbers") private var showDotNumbers: Bool = true
	@AppStorage("show_dot_hazard_class") private var showDotHazardClass: Bool = true

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

	@AppStorage("show_magnetic_type") private var showMagneticType: Bool = true
	@AppStorage("show_magnetic_susceptibility_mass") private var showMagSusMass: Bool = true
	@AppStorage("show_magnetic_susceptibility_molar") private var showMagSusMolar: Bool = true
	@AppStorage("show_magnetic_susceptibility_volume") private var showMagSusVolume: Bool = true

	@AppStorage("show_thermal_conductivity") private var showThermalConductivity: Bool = true
	@AppStorage("show_electrical_conductivity") private var showElectricalConductivity: Bool = true
	@AppStorage("show_resistivity") private var showResistivity: Bool = true
	@AppStorage("show_electrical_type") private var showElectricalType: Bool = true
	@AppStorage("show_electron_affinity") private var showElectronAffinity: Bool = true
	@AppStorage("show_electronegativity_pauling") private var showElectronegativityPauling: Bool = true
	@AppStorage("show_ionization_energies") private var showIonizationEnergies: Bool = true

	@AppStorage("show_crystal_structure") private var showCrystalStructure: Bool = true
	@AppStorage("show_lattice_angles") private var showLatticeAngles: Bool = true
	@AppStorage("show_lattice_constants") private var showLatticeConstants: Bool = true
	@AppStorage("show_space_group_name") private var showSpaceGroupName: Bool = true
	@AppStorage("show_space_group_number") private var showSpaceGroupNumber: Bool = true

	@AppStorage("show_known_isotopes") private var showKnownIsotopes: Bool = true
	@AppStorage("show_isotopic_abundances") private var showIsotopicAbundances: Bool = true
	@AppStorage("show_half_life") private var showHalfLife: Bool = true
	@AppStorage("show_lifetime") private var showLifetime: Bool = true
	@AppStorage("show_decay_mode") private var showDecayMode: Bool = true
	@AppStorage("show_neutron_cross_section") private var showNeutronCrossSection: Bool = true
	@AppStorage("show_neutron_mass_absorption") private var showNeutronMassAbsorption: Bool = true

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

	@AppStorage("show_summary") private var showSummary: Bool = true
	@AppStorage("show_source") private var showSourceRow: Bool = true

	private var settingsSections: [SectionSetting] {
		[
			SectionSetting(
				header: "Shells",
				sectionBinding: $showSectionShells,
				rows: [
				]
			),

			SectionSetting(
				header: "Atomic Structure",
				sectionBinding: $showSectionAtomic,
				rows: [
					RowSetting(name: "Atomic Mass", binding: $showAtomicMass),
					RowSetting(name: "Valence Electrons", binding: $showValenceElectrons),
					RowSetting(name: "Electron Configuration", binding: $showElectronConfiguration),
					RowSetting(name: "Semantic Electron Configuration", binding: $showElectronConfigurationSemantic),
					RowSetting(name: "Quantum Numbers", binding: $showQuantumNumbers),
					RowSetting(name: "Oxidation States", binding: $showOxidationStates),
				]
			),

			SectionSetting(
				header: "Thermodynamics",
				sectionBinding: $showSectionThermo,
				rows: [
					RowSetting(name: "Melting Point", binding: $showMeltingPoint),
					RowSetting(name: "Boiling Point", binding: $showBoilingPoint),
					RowSetting(name: "Critical Temperature", binding: $showCriticalTemperature),
					RowSetting(name: "Critical Pressure", binding: $showCriticalPressure),
					RowSetting(name: "Curie Point", binding: $showCuriePoint),
					RowSetting(name: "Neel Point", binding: $showNeelPoint),
					RowSetting(name: "Superconducting Point", binding: $showSuperconductingPoint),
					RowSetting(name: "Thermal Expansion", binding: $showThermalExpansion),
					RowSetting(name: "Specific Heat", binding: $showSpecificHeat),
					RowSetting(name: "Heat of Fusion", binding: $showHeatOfFusion),
					RowSetting(name: "Heat of Vaporization", binding: $showHeatOfVaporization),
					RowSetting(name: "Molar Heat Capacity", binding: $showMolarHeatCapacity),
				]
			),

			SectionSetting(
				header: "Classification",
				sectionBinding: $showSectionClassification,
				rows: [
					RowSetting(name: "Block", binding: $showBlock),
					RowSetting(name: "Group", binding: $showGroupRow),
					RowSetting(name: "Period", binding: $showPeriod),
					RowSetting(name: "CAS Number", binding: $showCasNumber),
					RowSetting(name: "CID Number", binding: $showCidNumber),
					RowSetting(name: "RTECS Number", binding: $showRtecsNumber),
					RowSetting(name: "DOT Number", binding: $showDotNumbers),
					RowSetting(name: "DOT Hazard Class", binding: $showDotHazardClass),
				]
			),

			SectionSetting(
				header: "Mechanical",
				sectionBinding: $showSectionMechanical,
				rows: [
					RowSetting(name: "Shear modulus", binding: $showShearModulus),
					RowSetting(name: "Young modulus", binding: $showYoungModulus),
					RowSetting(name: "Standard density", binding: $showStandardDensity),
					RowSetting(name: "Liquid density", binding: $showLiquidDensity),
					RowSetting(name: "Atomic/ionic radius", binding: $showAtomicIonicRadius),
					RowSetting(name: "Vickers hardness", binding: $showVickersHardness),
					RowSetting(name: "Mohs (calculated)", binding: $showMohsCalculated),
					RowSetting(name: "Mohs (MPa)", binding: $showMohsMPA),
					RowSetting(name: "Brinell hardness", binding: $showBrinellHardness),
					RowSetting(name: "Bulk modulus", binding: $showBulkModulus),
					RowSetting(name: "Poisson ratio", binding: $showPoissonRatio),
					RowSetting(name: "Speed of sound", binding: $showSpeedOfSound),
				]
			),

			SectionSetting(
				header: "Magnetic",
				sectionBinding: $showSectionMagnetic,
				rows: [
					RowSetting(name: "Magnetic Type", binding: $showMagneticType),
					RowSetting(name: "Magnetic Susceptibility - Mass", binding: $showMagSusMass),
					RowSetting(name: "Magnetic Susceptibility - Molar", binding: $showMagSusMolar),
					RowSetting(name: "Magnetic Susceptibility - Volume", binding: $showMagSusVolume),
				]
			),

			SectionSetting(
				header: "Electrical",
				sectionBinding: $showSectionElectrical,
				rows: [
					RowSetting(name: "Thermal Conductivity", binding: $showThermalConductivity),
					RowSetting(name: "Electrical Conductivity", binding: $showElectricalConductivity),
					RowSetting(name: "Resistivity", binding: $showResistivity),
					RowSetting(name: "Electrical Type", binding: $showElectricalType),
					RowSetting(name: "Electron Affinity", binding: $showElectronAffinity),
					RowSetting(name: "Electronegativity (Pauling)", binding: $showElectronegativityPauling),
					RowSetting(name: "Ionization Energies", binding: $showIonizationEnergies),
				]
			),

			SectionSetting(
				header: "Crystal",
				sectionBinding: $showSectionCrystal,
				rows: [
					RowSetting(name: "Crystal Structure", binding: $showCrystalStructure),
					RowSetting(name: "Lattice Angles", binding: $showLatticeAngles),
					RowSetting(name: "Lattice Constants", binding: $showLatticeConstants),
					RowSetting(name: "Space Group Name", binding: $showSpaceGroupName),
					RowSetting(name: "Space Group Number", binding: $showSpaceGroupNumber),
				]
			),

			SectionSetting(
				header: "Nuclear",
				sectionBinding: $showSectionNuclear,
				rows: [
					RowSetting(name: "Known Isotopes", binding: $showKnownIsotopes),
					RowSetting(name: "Isotopic Abundances", binding: $showIsotopicAbundances),
					RowSetting(name: "Half Life / Radioactivity", binding: $showHalfLife),
					RowSetting(name: "Lifetime", binding: $showLifetime),
					RowSetting(name: "Decay Type", binding: $showDecayMode),
					RowSetting(name: "Neutron Cross Section", binding: $showNeutronCrossSection),
					RowSetting(name: "Neutron Mass Absorption", binding: $showNeutronMassAbsorption),
				]
			),

			SectionSetting(
				header: "Other",
				sectionBinding: $showSectionOther,
				rows: [
					RowSetting(name: "Abundance", binding: $showAbundance),
					RowSetting(name: "Adiabatic Index", binding: $showAdiabaticIndex),
					RowSetting(name: "Energy Levels", binding: $showEnergyLevels),
					RowSetting(name: "Gas Phase", binding: $showGasPhase),
					RowSetting(name: "Molar Volume", binding: $showMolarVolume),
					RowSetting(name: "Radius - Calculated", binding: $showRadiusCalculated),
					RowSetting(name: "Radius - Empirical", binding: $showRadiusEmpirical),
					RowSetting(name: "Radius - Covalent", binding: $showRadiusCovalent),
					RowSetting(name: "Radius - Vanderwaals", binding: $showRadiusVanderwaals),
					RowSetting(name: "Refractive Index", binding: $showRefractiveIndex),
					RowSetting(name: "Allotropes", binding: $showAllotropes),
				]
			),

			SectionSetting(
				header: "Info",
				sectionBinding: $showSectionInfo,
				rows: [
					RowSetting(name: "Summary", binding: $showSummary),
					RowSetting(name: "Source", binding: $showSourceRow),
				]
			),
		]
	}

	private var allBindings: [Binding<Bool>] {
		var all: [Binding<Bool>] = []
		for section in settingsSections {
			if let sb = section.sectionBinding {
				all.append(sb)
			}
			for row in section.rows {
				all.append(row.binding)
			}
		}
		return all
	}

	func setAll(_ value: Bool) {
		allBindings.forEach { $0.wrappedValue = value }
	}

	func toggleAll() {
		let anyOff = allBindings.contains { !$0.wrappedValue }
		setAll(anyOff)
	}

	var body: some View {
		NavigationStack {
			List {
				NavigationLink {
					visibility
						.toolbar {
							ToolbarItem(placement: .title) {
								Label("Visibility", systemImage: "circle.lefthalf.filled")
									.labelStyle(.titleAndIcon)
									.monospaced()
							}
							ToolbarItem(placement: .primaryAction) {
								Button(action: {
									setAll(!allEnabled)
								}) {
									Label(allEnabled ? "Disable All" : "Enable All",
									      systemImage: allEnabled ? "eye.slash" : "eye")
								}
							}
						}
				} label: {
					Label("Visibility", systemImage: "circle.lefthalf.filled")
				}
			}

			.toolbar {
				ToolbarItem(placement: .title) {
					Label("Settings", systemImage: "gearshape")
						.labelStyle(.titleAndIcon)
						.monospaced()
				}
			}
		}
	}

	private var allEnabled: Bool {
		allBindings.allSatisfy { $0.wrappedValue }
	}

	var visibility: some View {
		List {
			Section(header: Text("Shells")) {
				Toggle("Shells (graphic)", isOn: $showSectionShells)
			}

			Section(header: Text("Atomic Structure")) {
				Toggle("Atomic Structure", isOn: $showSectionAtomic)
				DisclosureGroup("Rows") {
					Toggle("Atomic Mass", isOn: $showAtomicMass)
					Toggle("Valence Electrons", isOn: $showValenceElectrons)
					Toggle("Electron Configuration", isOn: $showElectronConfiguration)
					Toggle("Semantic Electron Configuration", isOn: $showElectronConfigurationSemantic)
					Toggle("Quantum Numbers", isOn: $showQuantumNumbers)
					Toggle("Oxidation States", isOn: $showOxidationStates)
				}
			}

			Section(header: Text("Thermodynamics")) {
				Toggle("Thermodynamics", isOn: $showSectionThermo)
				DisclosureGroup("Rows") {
					Toggle("Melting Point", isOn: $showMeltingPoint)
					Toggle("Boiling Point", isOn: $showBoilingPoint)
					Toggle("Critical Temperature", isOn: $showCriticalTemperature)
					Toggle("Critical Pressure", isOn: $showCriticalPressure)
					Toggle("Curie Point", isOn: $showCuriePoint)
					Toggle("Neel Point", isOn: $showNeelPoint)
					Toggle("Superconducting Point", isOn: $showSuperconductingPoint)
					Toggle("Thermal Expansion", isOn: $showThermalExpansion)
					Toggle("Specific Heat", isOn: $showSpecificHeat)
					Toggle("Heat of Fusion", isOn: $showHeatOfFusion)
					Toggle("Heat of Vaporization", isOn: $showHeatOfVaporization)
					Toggle("Molar Heat Capacity", isOn: $showMolarHeatCapacity)
				}
			}

			Section(header: Text("Classification")) {
				Toggle("Classification", isOn: $showSectionClassification)
				DisclosureGroup("Rows") {
					Toggle("Block", isOn: $showBlock)
					Toggle("Group", isOn: $showGroupRow)
					Toggle("Period", isOn: $showPeriod)
					Toggle("CAS Number", isOn: $showCasNumber)
					Toggle("CID Number", isOn: $showCidNumber)
					Toggle("RTECS Number", isOn: $showRtecsNumber)
					Toggle("DOT Numbers", isOn: $showDotNumbers)
					Toggle("DOT Hazard Class", isOn: $showDotHazardClass)
				}
			}

			Section(header: Text("Mechanical")) {
				Toggle("Mechanical", isOn: $showSectionMechanical)
				DisclosureGroup("Rows") {
					Toggle("Shear Modulus", isOn: $showShearModulus)
					Toggle("Young Modulus", isOn: $showYoungModulus)
					Toggle("Standard Density", isOn: $showStandardDensity)
					Toggle("Liquid Density", isOn: $showLiquidDensity)
					Toggle("Atomic Ionic Radius", isOn: $showAtomicIonicRadius)
					Toggle("Vickers Hardness", isOn: $showVickersHardness)
					Toggle("Mohs Calculated", isOn: $showMohsCalculated)
					Toggle("Mohs MPA", isOn: $showMohsMPA)
					Toggle("Brinell Hardness", isOn: $showBrinellHardness)
					Toggle("Bulk Modulus", isOn: $showBulkModulus)
					Toggle("Poisson Ratio", isOn: $showPoissonRatio)
					Toggle("Speed of Sound", isOn: $showSpeedOfSound)
				}
			}

			Section(header: Text("Magnetic")) {
				Toggle("Magnetic", isOn: $showSectionMagnetic)
				DisclosureGroup("Rows") {
					Toggle("Magnetic Type", isOn: $showMagneticType)
					Toggle("Magnetic Susceptibility Mass", isOn: $showMagSusMass)
					Toggle("Magnetic Susceptibility Molar", isOn: $showMagSusMolar)
					Toggle("Magnetic Susceptibility Volume", isOn: $showMagSusVolume)
				}
			}

			Section(header: Text("Electrical")) {
				Toggle("Electrical", isOn: $showSectionElectrical)
				DisclosureGroup("Rows") {
					Toggle("Thermal Conductivity", isOn: $showThermalConductivity)
					Toggle("Electrical Conductivity", isOn: $showElectricalConductivity)
					Toggle("Resistivity", isOn: $showResistivity)
					Toggle("Electrical Type", isOn: $showElectricalType)
					Toggle("Electron Affinity", isOn: $showElectronAffinity)
					Toggle("Electronegativity Pauling", isOn: $showElectronegativityPauling)
					Toggle("Ionization Energies", isOn: $showIonizationEnergies)
				}
			}

			Section(header: Text("Crystal")) {
				Toggle("Crystal", isOn: $showSectionCrystal)
				DisclosureGroup("Rows") {
					Toggle("Crystal Structure", isOn: $showCrystalStructure)
					Toggle("Lattice Angles", isOn: $showLatticeAngles)
					Toggle("Lattice Constants", isOn: $showLatticeConstants)
					Toggle("Space Group Name", isOn: $showSpaceGroupName)
					Toggle("Space Group Number", isOn: $showSpaceGroupNumber)
				}
			}

			Section(header: Text("Nuclear")) {
				Toggle("Nuclear", isOn: $showSectionNuclear)
				DisclosureGroup("Rows") {
					Toggle("Known Isotopes", isOn: $showKnownIsotopes)
					Toggle("Isotopic Abundances", isOn: $showIsotopicAbundances)
					Toggle("Half Life / Radioactivity", isOn: $showHalfLife)
					Toggle("Lifetime", isOn: $showLifetime)
					Toggle("Decay Type", isOn: $showDecayMode)
					Toggle("Neutron Cross Section", isOn: $showNeutronCrossSection)
					Toggle("Neutron Mass Absorption", isOn: $showNeutronMassAbsorption)
				}
			}

			Section(header: Text("Other")) {
				Toggle("Other", isOn: $showSectionOther)
				DisclosureGroup("Rows") {
					Toggle("Abundance", isOn: $showAbundance)
					Toggle("Adiabatic Index", isOn: $showAdiabaticIndex)
					Toggle("Energy Levels", isOn: $showEnergyLevels)
					Toggle("Gas Phase", isOn: $showGasPhase)
					Toggle("Molar Volume", isOn: $showMolarVolume)
					Toggle("Radius - Calculated", isOn: $showRadiusCalculated)
					Toggle("Radius - Empirical", isOn: $showRadiusEmpirical)
					Toggle("Radius - Covalent", isOn: $showRadiusCovalent)
					Toggle("Radius - Vanderwaals", isOn: $showRadiusVanderwaals)
					Toggle("Refractive Index", isOn: $showRefractiveIndex)
					Toggle("Allotropes", isOn: $showAllotropes)
				}
			}

			Section(header: Text("Info")) {
				Toggle("Info", isOn: $showSectionInfo)
				DisclosureGroup("Rows") {
					Toggle("Summary", isOn: $showSummary)
					Toggle("Source", isOn: $showSourceRow)
				}
			}
		}
	}
}
