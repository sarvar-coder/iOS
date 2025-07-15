//
//  AnimalSearcherMock.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 15/07/25.
//

import Foundation

struct AnimalSearcherMock: AnimalSearcher {
    func searchAnimal(
        by text: String,
        age: AnimalSearchAge,
        type: AnimalSearchType
    ) async -> [Animal] {
        var animals = Animal.mock
        if age != .none {
            animals = animals.filter {
                $0.age.rawValue.lowercased() == age.rawValue.lowercased()
            }
        }
        if type != .none {
            animals = animals.filter {
                $0.type.lowercased() == type.rawValue.lowercased()
            }
        }
        return animals.filter { $0.name.contains(text) }
    }
}
