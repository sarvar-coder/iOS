//
//  ContentView.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var tabNavigator = PetSaveTabNavigator()
    @StateObject var locationManager = LocationManager()
    let viewContext = PersistenceController.shared.container.viewContext
    
    var body: some View {
        TabView(selection: $tabNavigator.currentTab) {
            AnimalsNearYouView(
                viewModel: AnimalsNearYouViewModel(
                    animalsFetcher: FetchAnimalsService(
                        manager: RequestManager()
                    ),
                    animalStore: AnimalStoreService(context: PersistenceController.shared.container.newBackgroundContext())
                )
            )
            .badge(2)
            .tag(PetSaveTabType.nearYou)
            .tabItem {
                Label("Near you", systemImage: "location")
            }
            .environment(\.managedObjectContext, viewContext)
            
            SearchView()
                .tag(PetSaveTabType.search)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .environment(\.managedObjectContext, viewContext)
        }
        .environmentObject(locationManager)
        .onOpenURL { url in
            let type = PetSaveTabType.deepLinkType(url: url)
            
            self.tabNavigator.switchTab(to: type)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LocationManager())
}
