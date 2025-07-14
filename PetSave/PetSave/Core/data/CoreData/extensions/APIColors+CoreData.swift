//
//  Persistence.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import CoreData

// MARK: - CoreDataPersistable
extension APIColors: CoreDataPersistable {
  var keyMap: [PartialKeyPath<APIColors>: String] {
    [
      \.primary: "primary",
      \.secondary: "secondary",
      \.tertiary: "tertiary"
    ]
  }

  typealias ManagedType = APIColorsEntity
}
