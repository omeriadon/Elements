//
//  Bookmark.swift
//  Elements
//
//  Created by Adon Omeri on 7/11/2025.
//

import Foundation
import SwiftData

@Model
class Bookmark: Identifiable {
	var id = UUID()
	var elementID: Int
	var dateAdded: Date

	init(elementID: Int, dateAdded: Date) {
		self.elementID = elementID
		self.dateAdded = dateAdded
	}
}
