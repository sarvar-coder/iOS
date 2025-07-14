//
//  AnimalAttributesCard.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 14/07/25.
//

import Foundation
import SwiftUI

struct AnimalAttributesCard: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .padding(4)
            .background(color.opacity(0.2))
            .cornerRadius(8)
            .foregroundColor(color)
            .font(.subheadline)
    }
}
