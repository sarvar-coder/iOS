//
//  AnimalsRequestMock.swift
//  PetSaveTests
//
//  Created by Sarvar Boltaboyev on 12/07/25.
//

import Foundation
@testable import PetSave
enum AnimalsRequestMock: RequestProtocol {
    case getAnimals
    // 1
    var requestType: RequestType {
        return .GET
    }
    // 2
    var path: String {
        guard let path = Bundle.main.path(forResource: "AnimalsMock", ofType: "json")
        else { return "" }
        return path
    }
}
