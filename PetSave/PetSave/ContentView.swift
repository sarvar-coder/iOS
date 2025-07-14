//
//  ContentView.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import SwiftUI

struct ContentView: View {
    
    let viewContext = PersistenceController.shared.container.viewContext
    
    var body: some View {
        TabView {
            AnimalsNearYouView(
                viewModel: AnimalsNearYouViewModel(
                    animalsFetcher: FetchAnimalsService(
                        manager: RequestManager()
                    ),
                    animalStore: AnimalStoreService(context: PersistenceController.shared.container.newBackgroundContext())
                )
            )
            .tabItem {
                Label("Near you", systemImage: "location")
            }
            .environment(\.managedObjectContext, viewContext)
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .environment(\.managedObjectContext, viewContext)
        }
    }
}

#Preview {
    ContentView()
}
