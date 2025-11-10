//
//  SwiftUIView.swift
//  Elements
//
//  Created by Adon Omeri on 9/11/2025.
//

import SwiftData
import SwiftUI

@Model
class Storage {
	var recentSearches: [String] // your array of strings

	init(recentSearches: [String] = []) {
		self.recentSearches = recentSearches
	}
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
		case let .block(b): return "Block \(b.rawValue.uppercased())"
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
