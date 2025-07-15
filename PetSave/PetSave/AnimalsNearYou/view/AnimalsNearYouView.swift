//
//  AnimalsNearYouView.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import SwiftUI

struct AnimalsNearYouView: View {
    
    @ObservedObject var viewModel: AnimalsNearYouViewModel
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
                    ProgressView("Finding more animals...")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .task {
                            await viewModel.fetchMoreAnimals()
                        }
                }
            }
            .task {
                await viewModel.fetchAnimals()
            }
            .overlay {
                if viewModel.isLoading && animals.isEmpty {
                    ProgressView("Finding Animals near you...")
                }
            }
            .navigationTitle("Animals near you")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AnimalsNearYouView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalsNearYouView(viewModel: AnimalsNearYouViewModel(animalsFetcher: AnimalsFetcherMock(), animalStore: AnimalStoreService(context: CoreDataHelper.previewContext)))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
