//
//  FetchAnimalsService.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 14/07/25.
//

import Foundation


struct FetchAnimalsService {
    private let manager: RequestManagerProtocol
    
    init(manager: RequestManagerProtocol) {
        self.manager = manager
    }
}

extension FetchAnimalsService: AnimalsFetcher {
    func fetchAnimals(page: Int, latitude: Double?, longitude: Double?) async -> [Animal] {
        let requestData = AnimalsRequest.getAnimalsWith(
            page: page, latitude: latitude, longitude: longitude)
        
        do {
            let animalsContainer: AnimalsContainer =
            try await  manager.perform(requestData)
            return animalsContainer.animals
        } catch {
            print("Error fetching... \(error.localizedDescription)")
            return []
        }
    }
}
