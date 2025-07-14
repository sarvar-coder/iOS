//
//  AnimalsNearYouViewModel.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 14/07/25.
//

import Foundation

protocol AnimalsFetcher {
    func fetchAnimals(page: Int) async -> [Animal]
}

protocol AnimalStore {
    func save(animals: [Animal]) async throws
}

@MainActor
final class AnimalsNearYouViewModel: ObservableObject {
    
    @Published var isLoading: Bool
   
    private let animalsFetcher: AnimalsFetcher
    private let animalStore: AnimalStore
    
    /// pagination
    @Published var hasMoreAnimals = true
    private(set) var page = 1
    
    init(isLoading: Bool = true, animalsFetcher: AnimalsFetcher, animalStore: AnimalStore) {
        self.isLoading = isLoading
        self.animalsFetcher = animalsFetcher
        self.animalStore = animalStore
    }
    
    
    func fetchAnimals() async {
        isLoading = true
        let animals = await animalsFetcher.fetchAnimals(page: page)
        
        do {
            try await animalStore.save(animals: animals)
        } catch {
        print("Error storing animals... \(error.localizedDescription)")
        }
        
        isLoading = false
        hasMoreAnimals = !animals.isEmpty
    }
    
    func fetchMoreAnimals() async {
    page += 1
    await fetchAnimals()
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
}
