//
//  AnimalStoreService.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 14/07/25.
//

import Foundation
import CoreData

struct AnimalStoreService {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
}

extension AnimalStoreService: AnimalStore {
    func save(animals: [Animal]) async throws {
        
        for var animal in animals {
            
            animal.toManagedObject(context: context)
        }
        
        try context.save()
    }
}
