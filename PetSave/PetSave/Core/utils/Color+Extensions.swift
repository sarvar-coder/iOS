//
//  Color+Extensions.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 17/07/25.
//

import Foundation
import SwiftUI

extension Color {
    func darken(_
                amount: Double) -> Color {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let darkenedUIColor =
        UIColor(
            red: min(red - amount / 100, 1.0),
            green: min(green - amount / 100, 1.0),
            blue: min(blue - amount / 100, 1.0),
            alpha: 1.0)
        return Color(darkenedUIColor)
    }
}
