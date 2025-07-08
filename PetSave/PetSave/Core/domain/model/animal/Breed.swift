//
//  Breed.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import Foundation

struct Breed: Codable {
    var id: Int?
    var primary: String?
    var secondary: String?
    var mixed: Bool?
    var unknown: Bool?
}
