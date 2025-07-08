//
//  Persistence.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import Foundation
import CoreData
import CoreTransferable

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    /// Dummy data for preview
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        
        let viewContext = result.container.viewContext
        
        for _ in 1...19 {
            let item = Item(context: viewContext)
            item.timeStamp = Date()
        }
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        
        return result
    }()
    
    /// Container 
    let container: NSPersistentContainer
    
    /// Life time
    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PetSave")
        
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
}
