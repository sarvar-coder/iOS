//
//  AnimalsFetcherMock.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 14/07/25.
//

import Foundation

struct AnimalsFetcherMock: AnimalsFetcher {
    func fetchAnimals(page: Int, latitude: Double?, longitude: Double?) async -> [Animal] {
        Animal.mock
    }
}

struct EmptyResponseAnimalsFetcherMock: AnimalsFetcher {
    func fetchAnimals(page: Int, latitude: Double?, longitude: Double?) async -> [Animal] {
        return []
    }
}
