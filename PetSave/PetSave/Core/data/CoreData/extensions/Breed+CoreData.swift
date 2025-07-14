//
//  Breed+CoreData.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 13/07/25.
//

import Foundation
import CoreData


extension Breed: CoreDataPersistable {
    var keyMap: [PartialKeyPath<Breed>: String] {
        [
            \.primary: "primary",
             \.secondary: "secondary",
             \.mixed: "mixed",
             \.unknown: "unknown",
             \.id: "id"
        ]
    }
    
    typealias ManagedType = BreedEntity
}
