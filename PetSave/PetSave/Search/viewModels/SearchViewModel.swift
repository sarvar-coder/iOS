//
//  SearchViewModel.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 15/07/25.
//

import Foundation

protocol AnimalSearcher {
    func searchAnimal(
        by text: String,
        age: AnimalSearchAge,
        type: AnimalSearchType
    ) async -> [Animal]
}

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var ageSelection = AnimalSearchAge.none
    @Published var typeSelection = AnimalSearchType.none
    
    private let animalSearcher: AnimalSearcher
    private let animalStore: AnimalStore
    
    init(animalSearcher: AnimalSearcher, animalStore: AnimalStore) {
        self.animalSearcher = animalSearcher
        self.animalStore = animalStore
    }
    
    var shouldFilter: Bool {
        !searchText.isEmpty || ageSelection != .none || typeSelection != .none
    }
    
    func search() {
        
        Task {
            let animals = await animalSearcher.searchAnimal(by: searchText, age: ageSelection, type: typeSelection)
            
            do {
                try await animalStore.save(animals: animals)
            } catch {
                print("Error storing animals: \(error.localizedDescription)")
            }
        }
    }
    
    func selectTypeSuggestion(_ type: AnimalSearchType) {
        typeSelection = type
        search()
    }
    
    func clearFilters() {
        typeSelection = .none
        ageSelection = .none
    }
}
