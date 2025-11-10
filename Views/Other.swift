//
//  SwiftUIView.swift
//  Elements
//
//  Created by Adon Omeri on 9/11/2025.
//

import SwiftUI

func colorForGroup(_ group: Int) -> Color {
	let clamped = min(max(group, 1), 18)
	let fraction = Double(clamped - 1) / 17.0

	let r = fraction
	let g = 0.5 * (1 - fraction)
	let b = 1 - fraction
	return Color(red: r, green: g, blue: b)
}

func colorForPeriod(_ period: Int) -> Color {
	let clamped = min(max(period, 1), 10)
	let fraction = Double(clamped - 1) / 6.0

	let r = fraction * 0.8 + 0.2
	let g = 1 - fraction * 0.5
	let b = fraction * 0.8 + 0.2
	return Color(red: r, green: g, blue: b)
}

struct LeftRight<Left: View, Right: View>: View {
	let left: () -> Left
	let right: () -> Right

	var body: some View {
		HStack {
			left()
			Spacer()
			right()
		}
	}
}

enum ElementToken: Identifiable, Hashable {
	case category(Category)
	case phase(ElementPhase)
	case group(Int)
	case period(Int)
	case block(Block)

	var id: String {
		switch self {
		case let .category(v): return "category-\(v.rawValue)"
		case let .phase(v): return "phase-\(v.rawValue)"
		case let .group(g): return "group-\(g)"
		case let .period(p): return "period-\(p)"
		case let .block(b): return "block-\(b.rawValue)"
		}
	}

	var label: String {
		switch self {
		case let .category(v): return v.rawValue.capitalized
		case let .phase(v): return v.rawValue.capitalized
		case let .group(g): return "Group \(g)"
		case let .period(p): return "Period \(p)"
		case let .block(b): return "\(String(b.name.first!).capitalized) Block"
		}
	}

	var symbol: String {
		switch self {
		case let .category(category):
			switch category {
			case .alkalineEarthMetal:
				"leaf"
			case .metalloid:
				"triangle.lefthalf.filled"
			case .nonmetal:
				"leaf.arrow.triangle.circlepath"
			case .nobleGas:
				"seal"
			case .alkaliMetal:
				"flame"
			case .postTransitionMetal:
				"cube"
			case .transitionMetal:
				"gearshape"
			case .lanthanide:
				"sun.min"
			case .actinide:
				"atom"
			}

		case let .phase(phase):
			switch phase {
			case .solid:
				"cube"
			case .liquid:
				"drop"
			case .gas:
				"bubbles.and.sparkles"
			}

		case .period:
			"chevron.left.chevron.right"

		case .group:
			"chevron.up.chevron.down"

		case let .block(block):
			switch block {
			case .sBlock:
				"s.square"
			case .pBlock:
				"p.square"
			case .dBlock:
				"d.square"
			case .fBlock:
				"f.square"
			}
		}
	}

	var color: Color {
		switch self {
		case let .category(category):
			return category.themeColor

		case let .phase(phase):
			switch phase {
			case .solid: return Color(red: 0.8, green: 0.8, blue: 0.8)
			case .liquid: return Color(red: 0.6, green: 0.8, blue: 1.0)
			case .gas: return Color(red: 1.0, green: 1.0, blue: 0.7)
			}

		case let .group(g): return colorForGroup(g)

		case let .period(p): return colorForPeriod(p)

		case let .block(block):
			switch block {
			case .sBlock: return Color(red: 1.0, green: 0.8, blue: 0.6)
			case .pBlock: return Color(red: 0.7, green: 0.9, blue: 0.7)
			case .dBlock: return Color(red: 0.6, green: 0.8, blue: 1.0)
			case .fBlock: return Color(red: 1.0, green: 0.75, blue: 0.5)
			}
		}
	}
}

func allTokens() -> [ElementToken] {
	var t: [ElementToken] = []
	t += Category.allCases.map { .category($0) }
	t += ElementPhase.allCases.map { .phase($0) }
	t += (1 ... 18).map { .group($0) }
	t += (1 ... 7).map { .period($0) }
	t += Block.allCases.map { .block($0) }
	return t
}
