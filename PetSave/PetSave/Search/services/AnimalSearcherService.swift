//
//  AnimalSearcherService.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 15/07/25.
//

import Foundation

struct AnimalSearcherService {
    let requestManager: RequestManagerProtocol
}

extension AnimalSearcherService: AnimalSearcher  {
    
    func searchAnimal(by text: String, age: AnimalSearchAge, type: AnimalSearchType) async -> [Animal] {
        
        let requestData = AnimalsRequest.getAnimalsBy(
            name: text,
            age: age != .none ? age.rawValue : nil,
            type: type != .none ? type.rawValue : nil)
        do {
            let animalsContainer: AnimalsContainer = try await requestManager.perform(requestData)
            return animalsContainer.animals
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
