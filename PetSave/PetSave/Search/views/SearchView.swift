//
//  ContentView.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = SearchViewModel(
        animalSearcher: AnimalSearcherService(requestManager: RequestManager()),
        animalStore: AnimalStoreService(context: PersistenceController.shared.container.newBackgroundContext()))
    @FetchRequest(
        sortDescriptors:[
            NSSortDescriptor(keyPath: \AnimalEntity.timestamp, ascending: true)
        ],
        animation: .default
    )
    private var animals: FetchedResults<AnimalEntity>
    @State var filterPickerIsPresented = false
    
    var filteredAnimals: [AnimalEntity] {
        guard viewModel.shouldFilter else { return [] }
        return filterAnimals()
    }
    
    var filterAnimals: FilterAnimals {
        FilterAnimals(animals: animals,
                      query: viewModel.searchText,
                      age: viewModel.ageSelection,
                      type: viewModel.typeSelection)
    }
    
    var body: some View {
        NavigationView {
            AnimalListView(animals: filteredAnimals)
                .overlay {
                    if filteredAnimals.isEmpty && !viewModel.searchText.isEmpty {
                        EmptyResultsView(query: viewModel.searchText)
                    }
                }
                .toolbar {
                    ToolbarItem {
                        Button {
                            filterPickerIsPresented.toggle()
                        } label: {
                            
                            Label("Filter", systemImage: "slider.horizontal.3")
                        }
                        .sheet(isPresented: $filterPickerIsPresented) {
                            NavigationView {
                                SearchFilterView(viewModel: viewModel)
                            }
                        }
                    }
                    
                }
                .overlay {
                    if filteredAnimals.isEmpty && viewModel.searchText.isEmpty {
                        SuggestionsGrid(suggestions: AnimalSearchType.suggestions) { suggestion in
                            viewModel.selectTypeSuggestion(suggestion)
                                
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    }
                }
                .searchable(
                    text: $viewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .always)
                )
                .onChange(of: viewModel.searchText) {
                    viewModel.search()
                }
                .navigationTitle("Find your future pet")
        }
    }
}

#Preview {
    SearchView(
        viewModel: SearchViewModel(
            animalSearcher: AnimalSearcherMock(),
            animalStore: AnimalStoreService(
                context: PersistenceController.preview.container.viewContext
            )
        )
    )
    .environment(
        \.managedObjectContext,
         PersistenceController.preview.container.viewContext
    )
}

