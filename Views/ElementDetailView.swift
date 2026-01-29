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
	@Environment(\.modelContext) private var modelContext
	@Query private var bookmarks: [Bookmark]

	private var isBookmarked: Bool { !bookmarks.isEmpty }

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
								} else {
									Label("Add Bookmark", systemImage: "bookmark")
										.transition(.blurReplace)
								}
							}
							.animation(.easeInOut, value: isBookmarked)
						}
						.buttonStyle(.plain)
						.popoverTip(bookmarksTip, attachmentAnchor: .point(.topLeading))
					}

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
							copyElementNameTip.invalidate(reason: .actionPerformed)
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
						.popoverTip(copyElementNameTip, attachmentAnchor: .point(.bottom))
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
			(showValenceElectrons && element.valenceElectrons != nil)
	}

	private var thermoDynamicHasVisibleRow: Bool {
		(showMeltingPoint && element.meltingPoint != nil) ||
			(showBoilingPoint && element.boilingPoint != nil) ||
			(showCriticalTemperature && element.criticalTemperature != nil) ||
			(showCriticalPressure && element.criticalPressure != nil) ||
			(showCuriePoint && element.curiePoint != nil) ||
			(showNeelPoint && element.neelPoint != nil) ||
			(showSuperconductingPoint && element.superconductingPoint != nil)
	}

	private var classificationHasVisibleRow: Bool {
		showBlock ||
			showGroupRow ||
			showPeriod
	}

	private var mechanicalHasVisibleRow: Bool {
		(showShearModulus && element.density?.shear != nil) ||
			(showYoungModulus && element.density?.young != nil) ||
			(showStandardDensity && element.density?.stp != nil) ||
			(showAtomicIonicRadius && element.hardness?.radius != nil) ||
			(showVickersHardness && element.hardness?.vickers != nil) ||
			(showMohsCalculated && element.hardness?.vickers != nil) ||
			(showMohsMPA && element.hardness?.mohs != nil) ||
			(showSpeedOfSound && element.speedOfSound != nil)
	}

	private var magneticHasVisibleRow: Bool {
		showMagneticType && element.magneticType != nil
	}

	private var electricalHasVisibleRow: Bool {
		showElectricalType && element.electricalType != nil
	}

	private var crystalHasVisibleRow: Bool {
		showCrystalStructure && element.crystalStructure != nil
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
			(showDecayMode && element.decayMode != nil)
	}

	private var otherHasVisibleRow: Bool {
		showAbundance ||
			(showRadiusCalculated && element.radius?.calculated != nil) ||
			(showRefractiveIndex && element.refractiveIndex != nil) ||
			(showAllotropes && element.allotropes != nil)
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
