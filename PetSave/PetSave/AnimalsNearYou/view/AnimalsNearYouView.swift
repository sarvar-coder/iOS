//
//  AnimalsNearYouView.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import SwiftUI

struct AnimalsNearYouView: View {
    
    @ObservedObject var viewModel: AnimalsNearYouViewModel
    @EnvironmentObject var locationManager: LocationManager
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \AnimalEntity.timestamp, ascending: true)
        ],
        animation: .easeInOut)
    private var animals: FetchedResults<AnimalEntity>
    
    
    var body: some View {
        NavigationView {       
            AnimalListView(animals: animals) {
                if !animals.isEmpty && viewModel.hasMoreAnimals {
                    HStack(alignment: .center) {
                        LoadingAnimation()
                            .frame(maxWidth: 125, minHeight: 125)
                        Text("Loading more animals...")
                    }
                    .task {
                        await viewModel.fetchMoreAnimals(location: locationManager.lastSeenLocation)
                    }
                }
            }
            .task {
                await viewModel.fetchAnimals(location: locationManager.lastSeenLocation)
            }
            .listStyle(.plain)
            .navigationTitle("Animals near you")
            .overlay {
                if viewModel.isLoading && animals.isEmpty {
                    ProgressView("Finding Animals near you...")
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AnimalsNearYouView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalsNearYouView(viewModel: AnimalsNearYouViewModel(animalsFetcher: AnimalsFetcherMock(), animalStore: AnimalStoreService(context: CoreDataHelper.previewContext)))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(LocationManager())
    }
}

class NavigationState: ObservableObject {
    @Published var isNavigatingDisabled = false
}
