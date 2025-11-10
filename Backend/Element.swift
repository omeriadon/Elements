//
//  Element.swift
//  Elements
//
//  Created by Adon Omeri on 7/11/2025.
//

import Foundation
import SwiftUI

struct Element: Decodable, Identifiable, Equatable {
	static func == (lhs: Element, rhs: Element) -> Bool {
		lhs.name == rhs.name
	}

	let id = UUID()
	let name: String
	let symbol: String
	let abundance: Abundance
	let adiabaticIndex: String?
	let allotropes: String?
	let alternateNames: String?
	let appearance: String?
	let atomicMass: Double
	let atomicNumber: Int
	let block: Block
	let boilingPoint: Double?
	let classifications: Classifications
	let conductivity: Conductivity?
	let cpkHex: String?
	let criticalPressure: Double?
	let criticalTemperature: Double?
	let crystalStructure: CrystalStructure?
	let curiePoint: Double?
	let decayMode: DecayMode?
	let density: Density?
	let discovered: Discovery?
	let electricalType: ElectricalType?
	let electronAffinity: Double?
	let electronConfiguration: String
	let electronConfigurationSemantic: String
	let electronegativityPauling: Double?
	let electronsPerShell: [Int]
	let energyLevels: String
	let gasPhase: GasPhase?
	let group: Int
	let halfLife: HalfLife?
	let hardness: Hardness?
	let heat: Heat?
	let ionizationEnergies: [Double]?
	let isotopesKnown: String?
	let isotopesStable: String?
	let isotopicAbundances: String?
	let latticeAngles: String?
	let latticeConstants: String?
	let lifetime: Lifetime?
	let magneticSusceptibility: MagneticSusceptibility?
	let magneticType: MagneticType?
	let meltingPoint: Double?
	let modulus: Modulus?
	let molarVolume: Double?
	let neelPoint: Double?
	let neutronCrossSection: Double?
	let neutronMassAbsorption: Double?
	let oxidationStates: String?
	let period: Int
	let phase: ElementPhase
	let poissonRatio: Double?
	let quantumNumbers: String
	let radius: Radius?
	let refractiveIndex: Double?
	let resistivity: Double?
	let series: Category
	let source: String
	let spaceGroupName: String?
	let spaceGroupNumber: Int?
	let speedOfSound: Double?
	let summary: String
	let superconductingPoint: Double?
	let thermalExpansion: Double?
	let valenceElectrons: Int?

	enum CodingKeys: String, CodingKey {
		case name, symbol, abundance, adiabaticIndex = "adiabatic_index", allotropes
		case alternateNames = "alternate_names", appearance
		case atomicMass = "atomic_mass"
		case atomicNumber = "atomic_number"
		case block
		case boilingPoint = "boiling_point"
		case classifications, conductivity, cpkHex = "cpk_hex"
		case criticalPressure = "critical_pressure"
		case criticalTemperature = "critical_temperature"
		case crystalStructure = "crystal_structure"
		case curiePoint = "curie_point"
		case decayMode = "decay_mode"
		case density, discovered
		case electricalType = "electrical_type"
		case electronAffinity = "electron_affinity"
		case electronConfiguration = "electron_configuration"
		case electronConfigurationSemantic = "electron_configuration_semantic"
		case electronegativityPauling = "electronegativity_pauling"
		case electronsPerShell = "electrons_per_shell"
		case energyLevels = "energy_levels"
		case gasPhase = "gas_phase"
		case group
		case halfLife = "half_life"
		case hardness, heat
		case ionizationEnergies = "ionization_energies"
		case isotopesKnown = "isotopes_known"
		case isotopesStable = "isotopes_stable"
		case isotopicAbundances = "isotopic_abundances"
		case latticeAngles = "lattice_angles"
		case latticeConstants = "lattice_constants"
		case lifetime
		case magneticSusceptibility = "magnetic_susceptibility"
		case magneticType = "magnetic_type"
		case meltingPoint = "melting_point"
		case modulus
		case molarVolume = "molar_volume"
		case neelPoint = "neel_point"
		case neutronCrossSection = "neutron_cross_section"
		case neutronMassAbsorption = "neutron_mass_absorption"
		case oxidationStates = "oxidation_states"
		case period, phase
		case poissonRatio = "poisson_ratio"
		case quantumNumbers = "quantum_numbers"
		case radius
		case refractiveIndex = "refractive_index"
		case resistivity, series, source
		case spaceGroupName = "space_group_name"
		case spaceGroupNumber = "space_group_number"
		case speedOfSound = "speed_of_sound"
		case summary
		case superconductingPoint = "superconducting_point"
		case thermalExpansion = "thermal_expansion"
		case valenceElectrons = "valence_electrons"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		// Required fields
		name = try container.decode(String.self, forKey: .name)
		symbol = try container.decode(String.self, forKey: .symbol)
		atomicMass = try container.decode(Double.self, forKey: .atomicMass)
		atomicNumber = try container.decode(Int.self, forKey: .atomicNumber)
		electronsPerShell = try container.decode([Int].self, forKey: .electronsPerShell)
		phase = try container.decode(ElementPhase.self, forKey: .phase)
		series = try container.decode(Category.self, forKey: .series)

		// Abundance - if missing, default to synthetic (all zeros)
		if let abundanceData = try? container.decode(Abundance.self, forKey: .abundance) {
			abundance = abundanceData
		} else {
			abundance = Abundance.synthetic
		}

		// Optional fields
		adiabaticIndex = try? container.decode(String.self, forKey: .adiabaticIndex)
		allotropes = try? container.decode(String.self, forKey: .allotropes)
		alternateNames = try? container.decode(String.self, forKey: .alternateNames)
		appearance = try? container.decode(String.self, forKey: .appearance)
		block = try container.decode(Block.self, forKey: .block)
		boilingPoint = try? container.decode(Double.self, forKey: .boilingPoint)
		classifications = try container.decode(Classifications.self, forKey: .classifications)
		conductivity = try? container.decode(Conductivity.self, forKey: .conductivity)
		cpkHex = try? container.decode(String.self, forKey: .cpkHex)
		criticalPressure = try? container.decode(Double.self, forKey: .criticalPressure)
		criticalTemperature = try? container.decode(Double.self, forKey: .criticalTemperature)
		crystalStructure = try? container.decode(CrystalStructure.self, forKey: .crystalStructure)
		curiePoint = try? container.decode(Double.self, forKey: .curiePoint)
		decayMode = try? container.decode(DecayMode.self, forKey: .decayMode)
		density = try? container.decode(Density.self, forKey: .density)
		discovered = try? container.decode(Discovery.self, forKey: .discovered)
		electricalType = try? container.decode(ElectricalType.self, forKey: .electricalType)
		electronAffinity = try? container.decode(Double.self, forKey: .electronAffinity)
		electronConfiguration = try container.decode(String.self, forKey: .electronConfiguration)
		electronConfigurationSemantic = try container.decode(String.self, forKey: .electronConfigurationSemantic)
		electronegativityPauling = try? container.decode(Double.self, forKey: .electronegativityPauling)
		energyLevels = try container.decode(String.self, forKey: .energyLevels)
		gasPhase = try? container.decode(GasPhase.self, forKey: .gasPhase)
		group = try container.decode(Int.self, forKey: .group)
		halfLife = try? container.decode(HalfLife.self, forKey: .halfLife)
		hardness = try? container.decode(Hardness.self, forKey: .hardness)
		heat = try? container.decode(Heat.self, forKey: .heat)
		ionizationEnergies = try? container.decode([Double].self, forKey: .ionizationEnergies)
		isotopesKnown = try? container.decode(String.self, forKey: .isotopesKnown)
		isotopesStable = try? container.decode(String.self, forKey: .isotopesStable)
		isotopicAbundances = try? container.decode(String.self, forKey: .isotopicAbundances)
		latticeAngles = try? container.decode(String.self, forKey: .latticeAngles)
		latticeConstants = try? container.decode(String.self, forKey: .latticeConstants)
		lifetime = try? container.decode(Lifetime.self, forKey: .lifetime)
		magneticSusceptibility = try? container.decode(MagneticSusceptibility.self, forKey: .magneticSusceptibility)
		magneticType = try? container.decode(MagneticType.self, forKey: .magneticType)
		meltingPoint = try? container.decode(Double.self, forKey: .meltingPoint)
		modulus = try? container.decode(Modulus.self, forKey: .modulus)
		molarVolume = try? container.decode(Double.self, forKey: .molarVolume)
		neelPoint = try? container.decode(Double.self, forKey: .neelPoint)
		neutronCrossSection = try? container.decode(Double.self, forKey: .neutronCrossSection)
		neutronMassAbsorption = try? container.decode(Double.self, forKey: .neutronMassAbsorption)
		oxidationStates = try? container.decode(String.self, forKey: .oxidationStates)
		period = try container.decode(Int.self, forKey: .period)
		poissonRatio = try? container.decode(Double.self, forKey: .poissonRatio)
		quantumNumbers = try container.decode(String.self, forKey: .quantumNumbers)
		radius = try? container.decode(Radius.self, forKey: .radius)
		refractiveIndex = try? container.decode(Double.self, forKey: .refractiveIndex)
		resistivity = try? container.decode(Double.self, forKey: .resistivity)
		source = try container.decode(String.self, forKey: .source)
		spaceGroupName = try? container.decode(String.self, forKey: .spaceGroupName)
		spaceGroupNumber = try? container.decode(Int.self, forKey: .spaceGroupNumber)
		speedOfSound = try? container.decode(Double.self, forKey: .speedOfSound)
		summary = try container.decode(String.self, forKey: .summary)
		superconductingPoint = try? container.decode(Double.self, forKey: .superconductingPoint)
		thermalExpansion = try? container.decode(Double.self, forKey: .thermalExpansion)
		valenceElectrons = try? container.decode(Int.self, forKey: .valenceElectrons)
	}
}

// MARK: - Enums

enum Block: String, Codable, CaseIterable {
	case sBlock = "s-block"
	case pBlock = "p-block"
	case dBlock = "d-block"
	case fBlock = "f-block"

	var name: String {
		switch self {
		case .sBlock:
			"s block"

		case .pBlock:
			"p block"

		case .dBlock:
			"d block"

		case .fBlock:
			"f block"
		}
	}
}

enum DecayMode: String, Codable {
	case alphaEmission = "AlphaEmission"
	case betaDecay = "BetaDecay"
	case betaPlusDecay = "BetaPlusDecay"
	case electronCapture = "ElectronCapture"

	var symbol: String {
		"exclamationmark.triangle"
	}

	var name: String {
		switch self {
		case .alphaEmission:
			"AlphaEmission"
		case .betaDecay:
			"BetaDecay"
		case .betaPlusDecay:
			"BetaPlusDecay"
		case .electronCapture:
			"ElectronCapture"
		}
	}
}

enum CrystalStructure: String, Codable {
	case simpleHexagonal = "Simple Hexagonal"
	case simpleCubic = "Simple Cubic"
	case bodycenteredCubic = "Body-centered Cubic"
	case facecenteredCubic = "Face-centered Cubic"
	case facecenteredOrthorhombic = "Face-centered Orthorhombic"
	case baseOrthorhombic = "Base Orthorhombic"
	case simpleOrthorhombic = "Simple Orthorhombic"
	case basecenteredMonoclinic = "Base-centered Monoclinic"
	case simpleMonoclinic = "Simple Monoclinic"
	case simpleTriclinic = "Simple Triclinic"
	case simpleTrigonal = "Simple Trigonal"
	case centeredTetragonal = "Centered Tetragonal"
	case tetrahedralPacking = "Tetrahedral Packing"

	var name: String {
		switch self {
		case .simpleHexagonal:
			"Simple Hexagonal"
		case .simpleCubic:
			"Simple Cubic"
		case .bodycenteredCubic:
			"Body-centered Cubic"
		case .facecenteredCubic:
			"Face-centered Cubic"
		case .facecenteredOrthorhombic:
			"Face-centered Orthorhombic"
		case .baseOrthorhombic:
			"Base Orthorhombic"
		case .simpleOrthorhombic:
			"Simple Orthorhombic"
		case .basecenteredMonoclinic:
			"Base-centered Monoclinic"
		case .simpleMonoclinic:
			"Simple Monoclinic"
		case .simpleTriclinic:
			"Simple Triclinic"
		case .simpleTrigonal:
			"Simple Trigonal"
		case .centeredTetragonal:
			"Centered Tetragonal"
		case .tetrahedralPacking:
			"Tetrahedral Packing"
		}
	}
}

enum ElectricalType: String, Codable {
	case conductor = "Conductor"
	case insulator = "Insulator"
	case semiconductor = "Semiconductor"

	var symbol: String {
		switch self {
		case .conductor:
			"bolt.fill"
		case .insulator:
			"bolt.slash"
		case .semiconductor:
			"bolt"
		}
	}
}

enum GasPhase: String, Codable {
	case diatomic = "Diatomic"
	case monoatomic = "Monoatomic"

	var symbol: String {
		switch self {
		case .diatomic:
			"circle.grid.2x1"
		case .monoatomic:
			"circle"
		}
	}
}

enum MagneticType: String, Codable {
	case diamagnetic
	case paramagnetic
	case ferromagnetic
	case antiferromagnetic

	var symbol: String {
		switch self {
		case .diamagnetic:
			"arrow.up.left.and.arrow.down.right"
		case .paramagnetic:
			"arrow.down.right.and.arrow.up.left"
		case .ferromagnetic:
			"arrow.down.right.and.arrow.up.left.square.fill"
		case .antiferromagnetic:
			"arrow.up.and.down.and.arrow.left.and.right"
		}
	}
}

enum HalfLife: Decodable, Equatable {
	case stable
	case unstable(Double)

	var symbol: String {
		switch self {
		case .stable:
			"checkmark.shield"
		case .unstable:
			"exclamationmark.shield"
		}
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		if let stringValue = try? container.decode(String.self), stringValue == "Stable" {
			self = .stable
		} else if let doubleValue = try? container.decode(Double.self) {
			self = .unstable(doubleValue)
		} else {
			throw DecodingError.typeMismatch(HalfLife.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected 'Stable' or Double"))
		}
	}
}

enum Lifetime: Decodable {
	case stable
	case unstable(Double)

	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		if let stringValue = try? container.decode(String.self), stringValue == "Stable" {
			self = .stable
		} else if let doubleValue = try? container.decode(Double.self) {
			self = .unstable(doubleValue)
		} else {
			throw DecodingError.typeMismatch(Lifetime.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected 'Stable' or Double"))
		}
	}
}

// MARK: - Structs

struct Abundance: Decodable, Equatable {
	let universe: Double
	let solar: Double
	let meteor: Double
	let crust: Double
	let ocean: Double
	let human: Double

	var isSynthetic: Bool {
		return universe == 0 && solar == 0 && meteor == 0 && crust == 0 && ocean == 0 && human == 0
	}

	static var synthetic: Abundance {
		return Abundance(universe: 0, solar: 0, meteor: 0, crust: 0, ocean: 0, human: 0)
	}
}

struct Classifications: Decodable {
	let casNumber: String
	let cidNumber: String?
	let rtecsNumber: String?
	let dotNumbers: DotNumbers?
	let dotHazardClass: Double?

	enum CodingKeys: String, CodingKey {
		case casNumber = "cas_number"
		case cidNumber = "cid_number"
		case rtecsNumber = "rtecs_number"
		case dotNumbers = "dot_numbers"
		case dotHazardClass = "dot_hazard_class"
	}
}

enum DotNumbers: Decodable {
	case single(Int)
	case multiple(String)

	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		if let intValue = try? container.decode(Int.self) {
			self = .single(intValue)
		} else if let stringValue = try? container.decode(String.self) {
			self = .multiple(stringValue)
		} else {
			throw DecodingError.typeMismatch(DotNumbers.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected Int or String"))
		}
	}

	var description: String {
		switch self {
		case let .single(value):
			return String(value)
		case let .multiple(value):
			return value
		}
	}
}

struct Conductivity: Codable {
	let thermal: Double
	let electric: Double
}

struct Density: Codable {
	let stp: Double?
	let liquid: Double?
	let shear: Double?
	let young: Double?
}

struct Discovery: Codable {
	let year: Int
}

struct Heat: Codable {
	let specific: Double?
	let vaporization: Double?
	let fusion: Double?
	let molar: Double?
}

struct Hardness: Codable {
	let radius: Double?
	let mohs: Double?
	let vickers: Double?
	let brinell: Double?
}

struct MagneticSusceptibility: Codable {
	let mass: Double
	let molar: Double
	let volume: Double
}

struct Modulus: Codable {
	let bulk: Double?
	let shear: Double?
	let young: Double?
}

struct Radius: Codable {
	let calculated: Double?
	let empirical: Double?
	let covalent: Double?
	let vanderwaals: Double?
}

enum ElementPhase: String, Codable, CaseIterable {
	case solid = "Solid"
	case liquid = "Liquid"
	case gas = "Gas"

	var symbol: String {
		switch self {
		case .solid:
			"cube"
		case .liquid:
			"drop"
		case .gas:
			"bubbles.and.sparkles"
		}
	}
}

enum Category: String, Codable, CaseIterable {
	case alkalineEarthMetal = "alkaline earth metal"
	case metalloid
	case nonmetal
	case nobleGas = "noble gas"
	case alkaliMetal = "alkali metal"
	case postTransitionMetal = "post-transition metal"
	case transitionMetal = "transition metal"
	case lanthanide
	case actinide

	var themeColor: Color {
		switch self {
		case .alkaliMetal:
			return Color(red: 1.0, green: 107 / 255, blue: 53 / 255)
		case .alkalineEarthMetal:
			return Color(red: 126 / 255, green: 217 / 255, blue: 87 / 255)
		case .transitionMetal:
			return Color(red: 108 / 255, green: 117 / 255, blue: 125 / 255)
		case .postTransitionMetal:
			return Color(red: 176 / 255, green: 183 / 255, blue: 189 / 255)
		case .metalloid:
			return Color(red: 155 / 255, green: 89 / 255, blue: 182 / 255)
		case .nonmetal:
			return Color(red: 23 / 255, green: 162 / 255, blue: 184 / 255)
		case .nobleGas:
			return Color(red: 93 / 255, green: 169 / 255, blue: 1.0)
		case .lanthanide:
			return Color(red: 1.0, green: 209 / 255, blue: 102 / 255)
		case .actinide:
			return Color(red: 1.0, green: 143 / 255, blue: 163 / 255)
		}
	}
}

func loadElements() -> [Element] {
	do {
		let data = Data(elementsString.utf8)
		let decoder = JSONDecoder()
		return try decoder.decode([Element].self, from: data)
	} catch {
		fatalError("Failed to decode elements.json: \(error)")
	}
}
