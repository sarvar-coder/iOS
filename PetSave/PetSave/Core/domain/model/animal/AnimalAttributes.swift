//
//  AnimalAttributes.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import Foundation

struct AnimalAttributes: Codable {
    var id: Int?
    var spayedNeutered: Bool? = false
    var houseTrained: Bool? = false
    var declawed: Bool? = false
    var specialNeeds: Bool? = false
    var shotsCurrent: Bool? = false
}
