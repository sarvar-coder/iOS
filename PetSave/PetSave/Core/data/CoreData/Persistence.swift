//
//  Persistence.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import Foundation
import CoreData
import CloudKit
import CoreTransferable

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    /// Dummy data for preview
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        
        let viewContext = result.container.viewContext
        
        for i in 0..<10 {
            var animal = Animal.mock[i]
            animal.toManagedObject(context: viewContext)
        }
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        
        return result
    }()
    
    /// Container 
    let container: NSPersistentCloudKitContainer
    
    /// Life time
    private init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "PetSave")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(filePath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Occuring error: \(error.localizedDescription), n/ info: \(error.userInfo) ")
            }
        }
        
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    static func save() {
        
        let context = PersistenceController.shared.container.viewContext
        
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            fatalError("""
    \(#file), \
    \(#function), \
    \(error.localizedDescription)
    """)
        }
    }
}
