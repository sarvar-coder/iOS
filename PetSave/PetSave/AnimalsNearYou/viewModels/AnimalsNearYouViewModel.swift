//
//  AnimalsNearYouViewModel.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 14/07/25.
//

import Foundation
import CoreLocation

protocol AnimalsFetcher {
    func fetchAnimals(page: Int, latitude: Double?, longitude: Double?) async -> [Animal]
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
    
    
    func fetchAnimals(location: CLLocation?) async {
        isLoading = true
        do {
            
            let animals = await animalsFetcher.fetchAnimals(
                page: page,
                latitude: location?.coordinate.latitude,
                longitude: location?.coordinate.longitude
            )
            
            try await animalStore.save(animals: animals)
            
            hasMoreAnimals = !animals.isEmpty
        } catch {
            
            print("Error fetching animals... \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    func fetchMoreAnimals(location: CLLocation?) async {
    page += 1
    await fetchAnimals(location: location)
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
}
