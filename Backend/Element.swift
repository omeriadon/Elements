//
//  Element.swift
//  Elements
//
//  Created by Adon Omeri on 7/11/2025.
//

import SwiftUI

struct Element: Identifiable, Codable {
	let id: UUID = .init()
	let name: String
	let appearance: String?
	let atomic_mass: Double
	let boil: Double?
	let category: Category
	let number: Int
	let period: Int
	let group: Int
	let phase: ElementPhase
	let source: String
	let summary: String
	let symbol: String
	let xpos: Int
	let ypos: Int
	let wxpos: Int
	let wypos: Int
	let shells: [Int]

	enum CodingKeys: String, CodingKey {
		case name, appearance, atomic_mass, boil, category, number, period, group, phase, source, summary, symbol, xpos, ypos, wxpos, wypos, shells
	}
}

enum ElementPhase: String, Codable {
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

enum Category: String, Codable {
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
			// energetic / reactive — warm orange
			return Color(red: 1.0, green: 107 / 255, blue: 53 / 255) // #FF6B35
		case .alkalineEarthMetal:
			// stable/earthy — green
			return Color(red: 126 / 255, green: 217 / 255, blue: 87 / 255) // #7ED957
		case .transitionMetal:
			// metallic/neutral — steel gray
			return Color(red: 108 / 255, green: 117 / 255, blue: 125 / 255) // #6C757D
		case .postTransitionMetal:
			// lighter metal tone
			return Color(red: 176 / 255, green: 183 / 255, blue: 189 / 255) // #B0B7BD
		case .metalloid:
			// distinctive, between metal and nonmetal — purple
			return Color(red: 155 / 255, green: 89 / 255, blue: 182 / 255) // #9B59B6
		case .nonmetal:
			// clear / gaseous feel — teal
			return Color(red: 23 / 255, green: 162 / 255, blue: 184 / 255) // #17A2B8
		case .nobleGas:
			// inert, cool — light blue
			return Color(red: 93 / 255, green: 169 / 255, blue: 1.0) // #5DA9FF
		case .lanthanide:
			// rare-earth / warm gold
			return Color(red: 1.0, green: 209 / 255, blue: 102 / 255) // #FFD166
		case .actinide:
			// heavy / radioactive hint — deep salmon
			return Color(red: 1.0, green: 143 / 255, blue: 163 / 255) // #FF8FA3
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
