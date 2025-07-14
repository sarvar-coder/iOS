//
//  Persistence.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import CoreData

// MARK: - CoreDataPersistable
extension User: CoreDataPersistable {
  var keyMap: [PartialKeyPath<User>: String] {
    [
      \.name: "name",
      \.password: "password",
      \.extra: "extra",
      \.id: "id"
    ]
  }
  typealias ManagedType = UserEntity
}
