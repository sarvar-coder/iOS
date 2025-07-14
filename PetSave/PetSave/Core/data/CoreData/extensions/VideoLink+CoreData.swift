//
//  Persistence.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import CoreData

// MARK: - CoreDataPersistable
extension VideoLink: CoreDataPersistable {
  var keyMap: [PartialKeyPath<VideoLink>: String] {
    [
      \.embedded: "embedded",
      \.id: "id"
    ]
  }

  typealias ManagedType = VideoLinkEntity
}
