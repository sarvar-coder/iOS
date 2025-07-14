//
//  Persistence.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import CoreData

// MARK: - CoreDataPersistable
extension PhotoSizes: CoreDataPersistable {
  var keyMap: [PartialKeyPath<PhotoSizes>: String] {
    [
      \.small: "small",
      \.medium: "medium",
      \.large: "large",
      \.full: "full",
      \.id: "id"
    ]
  }

  typealias ManagedType = PhotoSizesEntity
}
