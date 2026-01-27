//
//  Other.swift
//  Elements
//
//  Created by Adon Omeri on 9/11/2025.
//

import SwiftUI

func colourForGroup(_ group: Int) -> Color {
    let clamped = min(max(group, 1), 18)
    let fraction = Double(clamped - 1) / 17.0

    let r = 0.6 * fraction + 0.2
    let g = 0.2 + 0.6 * (1 - fraction)
    let b = 0.7 - 0.5 * fraction

    return Color(red: r, green: g, blue: b)
}

func colourForPeriod(_ period: Int) -> Color {
    let clamped = min(max(period, 1), 10)
    let fraction = Double(clamped - 1) / 9.0

    let r = 0.2 + 0.6 * fraction
    let g = 0.7 - 0.5 * fraction
    let b = 0.3 + 0.7 * (1 - fraction)

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
