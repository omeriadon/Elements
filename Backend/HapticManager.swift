//
//  HapticManager.swift
//  Elements
//
//  Created by Adon Omeri on 29/1/2026.
//

import Foundation
import UIKit

@MainActor
final class HapticManager {
	static let shared = HapticManager()
	private let generator = UIImpactFeedbackGenerator(style: .heavy)

	private init() { generator.prepare() }

	func impact() {
		generator.impactOccurred()
		generator.prepare()
	}
}
