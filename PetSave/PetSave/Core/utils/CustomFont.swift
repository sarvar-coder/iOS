//
//  CustomFont.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 18/07/25.
//

import Foundation

enum CustomFont: String {
    case sheep_sans
}

extension String {
    static let customFont = CustomFont.sheep_sans.rawValue
}
