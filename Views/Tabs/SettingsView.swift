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

	// Atomic
	@AppStorage("show_atomic_mass") private var showAtomicMass: Bool = true
	@AppStorage("show_valence_electrons") private var showValenceElectrons: Bool = true

	// Thermal
	@AppStorage("show_melting_point") private var showMeltingPoint: Bool = true
	@AppStorage("show_boiling_point") private var showBoilingPoint: Bool = true
	@AppStorage("show_critical_temperature") private var showCriticalTemperature: Bool = true
	@AppStorage("show_critical_pressure") private var showCriticalPressure: Bool = true
	@AppStorage("show_curie_point") private var showCuriePoint: Bool = true
	@AppStorage("show_neel_point") private var showNeelPoint: Bool = true
	@AppStorage("show_superconducting_point") private var showSuperconductingPoint: Bool = true

	// Classification
	@AppStorage("show_block") private var showBlock: Bool = true
	@AppStorage("show_group") private var showGroupRow: Bool = true
	@AppStorage("show_period") private var showPeriod: Bool = true

	// Mechanical
	@AppStorage("show_shear_modulus") private var showShearModulus: Bool = true
	@AppStorage("show_young_modulus") private var showYoungModulus: Bool = true
	@AppStorage("show_standard_density") private var showStandardDensity: Bool = true
	@AppStorage("show_atomic_ionic_radius") private var showAtomicIonicRadius: Bool = true
	@AppStorage("show_vickers_hardness") private var showVickersHardness: Bool = true
	@AppStorage("show_mohs_calculated") private var showMohsCalculated: Bool = true
	@AppStorage("show_mohs_mpa") private var showMohsMPA: Bool = true
	@AppStorage("show_speed_of_sound") private var showSpeedOfSound: Bool = true

	// Magnetic
	@AppStorage("show_magnetic_type") private var showMagneticType: Bool = true

	// Electrical
	@AppStorage("show_electrical_type") private var showElectricalType: Bool = true

	// Crystal
	@AppStorage("show_crystal_structure") private var showCrystalStructure: Bool = true

	// Nuclear
	@AppStorage("show_known_isotopes") private var showKnownIsotopes: Bool = true
	@AppStorage("show_isotopic_abundances") private var showIsotopicAbundances: Bool = true
	@AppStorage("show_half_life") private var showHalfLife: Bool = true
	@AppStorage("show_lifetime") private var showLifetime: Bool = true
	@AppStorage("show_decay_mode") private var showDecayMode: Bool = true

	// Other
	@AppStorage("show_abundance") private var showAbundance: Bool = true
	@AppStorage("show_radius_calculated") private var showRadiusCalculated: Bool = true
	@AppStorage("show_refractive_index") private var showRefractiveIndex: Bool = true
	@AppStorage("show_allotropes") private var showAllotropes: Bool = true

	// Info
	@AppStorage("show_summary") private var showSummary: Bool = true
	@AppStorage("show_source") private var showSourceRow: Bool = true

	@AppStorage("appHasOpenedBefore") var appHasOpenedBefore: Bool = false

	private var detailSections: [SectionSetting] {
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
				]
			),

			SectionSetting(
				header: "Classification",
				sectionBinding: $showSectionClassification,
				rows: [
					RowSetting(name: "Block", binding: $showBlock),
					RowSetting(name: "Group", binding: $showGroupRow),
					RowSetting(name: "Period", binding: $showPeriod),
				]
			),

			SectionSetting(
				header: "Mechanical",
				sectionBinding: $showSectionMechanical,
				rows: [
					RowSetting(name: "Shear modulus", binding: $showShearModulus),
					RowSetting(name: "Young modulus", binding: $showYoungModulus),
					RowSetting(name: "Standard density", binding: $showStandardDensity),
					RowSetting(name: "Atomic/ionic radius", binding: $showAtomicIonicRadius),
					RowSetting(name: "Vickers hardness", binding: $showVickersHardness),
					RowSetting(name: "Mohs (calculated)", binding: $showMohsCalculated),
					RowSetting(name: "Mohs (MPa)", binding: $showMohsMPA),
					RowSetting(name: "Speed of sound", binding: $showSpeedOfSound),
				]
			),

			SectionSetting(
				header: "Magnetic",
				sectionBinding: $showSectionMagnetic,
				rows: [
					RowSetting(name: "Magnetic Type", binding: $showMagneticType),
				]
			),

			SectionSetting(
				header: "Electrical",
				sectionBinding: $showSectionElectrical,
				rows: [
					RowSetting(name: "Electrical Type", binding: $showElectricalType),
				]
			),

			SectionSetting(
				header: "Crystal",
				sectionBinding: $showSectionCrystal,
				rows: [
					RowSetting(name: "Crystal Structure", binding: $showCrystalStructure),
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
				]
			),

			SectionSetting(
				header: "Other",
				sectionBinding: $showSectionOther,
				rows: [
					RowSetting(name: "Abundance", binding: $showAbundance),
					RowSetting(name: "Radius - Calculated", binding: $showRadiusCalculated),
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
		for section in detailSections {
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
				} label: {
					Label("Visibility", systemImage: "circle.lefthalf.filled")
				}
				.listRowBackground(Rectangle().fill(.regularMaterial))

				Button {
					appHasOpenedBefore = false
				} label: {
					Label("Reopen Onboarding", systemImage: "hand.wave")
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
		allBindings.allSatisfy(\.wrappedValue)
	}

	var visibility: some View {
		List {
			Section {
				Toggle("Shells (graphic)", isOn: $showSectionShells)
			}

			Section {
				Toggle("Atomic Structure", isOn: $showSectionAtomic)
				DisclosureGroup("Rows") {
					Toggle("Atomic Mass", isOn: $showAtomicMass)
					Toggle("Valence Electrons", isOn: $showValenceElectrons)
				}
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
				}
			}

			Section {
				Toggle("Classification", isOn: $showSectionClassification)
				DisclosureGroup("Rows") {
					Toggle("Block", isOn: $showBlock)
					Toggle("Group", isOn: $showGroupRow)
					Toggle("Period", isOn: $showPeriod)
				}
			}

			Section {
				Toggle("Mechanical", isOn: $showSectionMechanical)
				DisclosureGroup("Rows") {
					Toggle("Shear Modulus", isOn: $showShearModulus)
					Toggle("Young Modulus", isOn: $showYoungModulus)
					Toggle("Standard Density", isOn: $showStandardDensity)
					Toggle("Atomic Ionic Radius", isOn: $showAtomicIonicRadius)
					Toggle("Vickers Hardness", isOn: $showVickersHardness)
					Toggle("Mohs Calculated", isOn: $showMohsCalculated)
					Toggle("Mohs MPA", isOn: $showMohsMPA)
					Toggle("Speed of Sound", isOn: $showSpeedOfSound)
				}
			}

			Section {
				Toggle("Magnetic", isOn: $showSectionMagnetic)
				DisclosureGroup("Rows") {
					Toggle("Magnetic Type", isOn: $showMagneticType)
				}
			}

			Section {
				Toggle("Electrical", isOn: $showSectionElectrical)
				DisclosureGroup("Rows") {
					Toggle("Electrical Type", isOn: $showElectricalType)
				}
			}

			Section {
				Toggle("Crystal", isOn: $showSectionCrystal)
				DisclosureGroup("Rows") {
					Toggle("Crystal Structure", isOn: $showCrystalStructure)
				}
			}

			Section {
				Toggle("Nuclear", isOn: $showSectionNuclear)
				DisclosureGroup("Rows") {
					Toggle("Known Isotopes", isOn: $showKnownIsotopes)
					Toggle("Isotopic Abundances", isOn: $showIsotopicAbundances)
					Toggle("Half Life / Radioactivity", isOn: $showHalfLife)
					Toggle("Lifetime", isOn: $showLifetime)
					Toggle("Decay Type", isOn: $showDecayMode)
				}
			}

			Section {
				Toggle("Other", isOn: $showSectionOther)
				DisclosureGroup("Rows") {
					Toggle("Abundance", isOn: $showAbundance)
					Toggle("Radius - Calculated", isOn: $showRadiusCalculated)
					Toggle("Refractive Index", isOn: $showRefractiveIndex)
					Toggle("Allotropes", isOn: $showAllotropes)
				}
			}

			Section {
				Toggle("Info", isOn: $showSectionInfo)
				DisclosureGroup("Rows") {
					Toggle("Summary", isOn: $showSummary)
					Toggle("Source", isOn: $showSourceRow)
				}
			}
		}
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
	}
}
