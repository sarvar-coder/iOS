//
//  Organization.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import Foundation

struct Organization: Codable {
    var id: Int?
    var contact: Contact?
    var distance: Double?
}

struct Contact: Codable {
    var id: Int?
    var email: String?
    var phone: String?
    var address: Address?
}

struct Address: Codable {
    var id: Int?
    var address1: String?
    var address2: String?
    var city: String?
    var state: String?
    var postcode: String?
    var country: String?
}
