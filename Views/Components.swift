//
//  SwiftUIView.swift
//  Elements
//
//  Created by Adon Omeri on 9/11/2025.
//

import SwiftUI

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
