//
//  AdoptionStatus.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import Foundation

enum AdoptionStatus: String, Codable {
    case adoptable
    case adopted
    case found
    case unknown
}
