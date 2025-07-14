//
//  Persistence.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import CoreData

// MARK: - CoreDataPersistable
extension AnimalEnvironment: CoreDataPersistable {
  var keyMap: [PartialKeyPath<AnimalEnvironment>: String] {
    [
      \.children: "children",
      \.dogs: "dogs",
      \.cats: "cats",
      \.id: "id"
    ]
  }

  typealias ManagedType = AnimalEnvironmentEntity
}
