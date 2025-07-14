//
//  Persistence.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import CoreData

// MARK: - CoreDataPersistable
extension AnimalAttributes: CoreDataPersistable {
  var keyMap: [PartialKeyPath<AnimalAttributes>: String] {
    [
      \.spayedNeutered: "spayedNeutered",
      \.houseTrained: "houseTrained",
      \.declawed: "declawed",
      \.specialNeeds: "specialNeeds",
      \.shotsCurrent: "shotsCurrent",
      \.id: "id"
    ]
  }

  typealias ManagedType = AnimalAttributesEntity
}
