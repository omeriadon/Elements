//
//  Tips.swift
//  Elements
//
//  Created by Adon Omeri on 29/1/2026.
//

import Foundation
import TipKit

struct TableViewTip: Tip {
	var title: Text {
		Text("Elements Are Clickable")
	}

	var message: Text? {
		Text("Press an element to see details about it")
	}

	var image: Image? {
		Image(systemName: "atom")
	}
}

struct SortTip: Tip {
	var title: Text {
		Text("Sort Elements")
	}

	var message: Text? {
		Text("You can sort elements by atomic number, name, symbol, or mass, ascending or descending.")
	}

	var image: Image? {
		Image(systemName: "arrow.up.arrow.down")
	}
}

struct FilterTip: Tip {
	var title: Text {
		Text("Fitler Elements")
	}

	var message: Text? {
		Text("You can filter elements by category, phase, group, period, or block, or a combination of those.")
	}

	var image: Image? {
		Image(systemName: "line.3.horizontal.decrease")
	}
}
