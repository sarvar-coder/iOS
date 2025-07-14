//
//  PetSaveApp.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import SwiftUI

@main
struct PetSaveApp: App {
    let viewContext = PersistenceController.preview.container.viewContext
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, viewContext)            
        }
    }
}
