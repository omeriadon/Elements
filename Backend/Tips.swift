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
