//
//  AnimalsContainer.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 12/07/25.
//

import Foundation

struct AnimalsContainer: Codable {
    let animals: [Animal]
    let pagination: Pagination
}
