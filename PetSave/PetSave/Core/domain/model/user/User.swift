//
//  User.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import Foundation

struct User: Codable {
    var name: String?
    var password: String?
    var id: Int?
    var extra: String?
}
