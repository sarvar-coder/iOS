//
//  Animal .swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 10/07/25.
//

import Foundation

struct Animal: Codable, Identifiable {
    var id: Int?
    let organizationId: String?
    let url: URL?
    let type: String
    let species: String?
    var breeds: Breed
    var colors: APIColors
    let age: Age
    let gender: Gender
    let size: Size
    let coat: Coat?
    let name: String
    let description: String?
    let photos: [PhotoSizes]
    let videos: [VideoLink]
    let status: AdoptionStatus
    var attributes: AnimalAttributes
    var environment: AnimalEnvironment?
    let tags: [String]
    var contact: Contact
    let publishedAt: String?
    let distance: Double?
    var ranking: Int? = 0
}

// MARK: Helper
extension Animal {
    var picture: URL? {
        photos.first?.medium ?? photos.first?.large
    }
}
