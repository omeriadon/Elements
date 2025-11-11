//
//  SettingsView.swift
//  Elements
//
//  Created by Adon Omeri on 11/11/2025.
//

import SwiftUI

struct SettingsView: View {
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

	// (All row-level keys repeated here so the settings and the detail view share the same storage)
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
						}
				} label: {
					Label("isibility", systemImage: "circle.lefthalf.filled")
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

	var visibility: some View {
		List {
			Section {
				Toggle("Shells (graphic)", isOn: $showSectionShells)
			} header: {
				Text("Shells")
			}

			Section {
				Toggle("Atomic Structure", isOn: $showSectionAtomic)
				DisclosureGroup("Rows") {
					Toggle("Atomic Mass", isOn: $showAtomicMass)
					Toggle("Valence Electrons", isOn: $showValenceElectrons)
					Toggle("Electron Configuration", isOn: $showElectronConfiguration)
					Toggle("Semantic Electron Configuration", isOn: $showElectronConfigurationSemantic)
					Toggle("Quantum Numbers", isOn: $showQuantumNumbers)
					Toggle("Oxidation States", isOn: $showOxidationStates)
				}
			} header: {
				Text("Atomic Structure")
			}

			Section {
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
			} header: {
				Text("Thermodynamics")
			}

			Section {
				Toggle("Classification", isOn: $showSectionClassification)
				DisclosureGroup("Rows") {
					Toggle("Block", isOn: $showBlock)
					Toggle("Group", isOn: $showGroupRow)
					Toggle("Period", isOn: $showPeriod)
					Toggle("CAS Number", isOn: $showCasNumber)
					Toggle("CID Number", isOn: $showCidNumber)
					Toggle("RTECS Number", isOn: $showRtecsNumber)
					Toggle("DOT Number", isOn: $showDotNumbers)
					Toggle("DOT Hazard Class", isOn: $showDotHazardClass)
				}
			} header: {
				Text("Classification")
			}

			Section {
				Toggle("Mechanical", isOn: $showSectionMechanical)
				DisclosureGroup("Rows") {
					Toggle("Shear modulus", isOn: $showShearModulus)
					Toggle("Young modulus", isOn: $showYoungModulus)
					Toggle("Standard density", isOn: $showStandardDensity)
					Toggle("Liquid density", isOn: $showLiquidDensity)
					Toggle("Atomic/ionic radius", isOn: $showAtomicIonicRadius)
					Toggle("Vickers hardness", isOn: $showVickersHardness)
					Toggle("Mohs (calculated)", isOn: $showMohsCalculated)
					Toggle("Mohs (MPa)", isOn: $showMohsMPA)
					Toggle("Brinell hardness", isOn: $showBrinellHardness)
					Toggle("Bulk modulus", isOn: $showBulkModulus)
					Toggle("Poisson ratio", isOn: $showPoissonRatio)
					Toggle("Speed of sound", isOn: $showSpeedOfSound)
				}
			} header: {
				Text("Mechanical")
			}

			Section {
				Toggle("Magnetic", isOn: $showSectionMagnetic)
				DisclosureGroup("Rows") {
					Toggle("Magnetic Type", isOn: $showMagneticType)
					Toggle("Magnetic Susceptibility - Mass", isOn: $showMagSusMass)
					Toggle("Magnetic Susceptibility - Molar", isOn: $showMagSusMolar)
					Toggle("Magnetic Susceptibility - Volume", isOn: $showMagSusVolume)
				}
			} header: {
				Text("Magnetic")
			}

			Section {
				Toggle("Electrical", isOn: $showSectionElectrical)
				DisclosureGroup("Rows") {
					Toggle("Thermal Conductivity", isOn: $showThermalConductivity)
					Toggle("Electrical Conductivity", isOn: $showElectricalConductivity)
					Toggle("Resistivity", isOn: $showResistivity)
					Toggle("Electrical Type", isOn: $showElectricalType)
					Toggle("Electron Affinity", isOn: $showElectronAffinity)
					Toggle("Electronegativity (Pauling)", isOn: $showElectronegativityPauling)
					Toggle("Ionization Energies", isOn: $showIonizationEnergies)
				}
			} header: {
				Text("Electrical")
			}

			Section {
				Toggle("Crystal", isOn: $showSectionCrystal)
				DisclosureGroup("Rows") {
					Toggle("Crystal Structure", isOn: $showCrystalStructure)
					Toggle("Lattice Angles", isOn: $showLatticeAngles)
					Toggle("Lattice Constants", isOn: $showLatticeConstants)
					Toggle("Space Group Name", isOn: $showSpaceGroupName)
					Toggle("Space Group Number", isOn: $showSpaceGroupNumber)
				}
			} header: {
				Text("Crystal")
			}

			Section {
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
			} header: {
				Text("Nuclear")
			}

			Section {
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
			} header: {
				Text("Other")
			}

			Section {
				Toggle("Info", isOn: $showSectionInfo)
				DisclosureGroup("Rows") {
					Toggle("Summary", isOn: $showSummary)
					Toggle("Source", isOn: $showSourceRow)
				}
			} header: {
				Text("Info")
			}
		}
	}
}
