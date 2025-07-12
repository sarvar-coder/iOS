//
//  RequestManagerTests.swift
//  PetSaveTests
//
//  Created by Sarvar Boltaboyev on 12/07/25.
//

import Foundation
import XCTest
@testable import PetSave

class RequestManagerTests: XCTestCase {
    private var requestManager: RequestManagerProtocol?
    
    override func setUp() {
        super.setUp()
        // 1
        guard let userDefaults = UserDefaults(suiteName: #file) else {
            return
            
        }
        userDefaults.removePersistentDomain(forName: #file)
        // 2
        requestManager = RequestManager(
            apiManager: APIManagerMock(),
            accessTokenManager: AccessTokenManager(userDefaults:
                                                    userDefaults)
        )
    }
    
    func testRequestAnimals() async throws {
        // 1
        guard let container: AnimalsContainer =
                try await requestManager?.perform(
                    AnimalsRequestMock.getAnimals) else {
            XCTFail("Didn't get data from the request manager")
            return
        }
        let animals = container.animals
        // 2
        let first = animals.first
        let last = animals.last
        // 3
        XCTAssertEqual(first?.name, "Kiki")
        XCTAssertEqual(first?.age.rawValue, "Adult")
        XCTAssertEqual(first?.gender.rawValue, "Female")
        XCTAssertEqual(first?.size.rawValue, "Medium")
        XCTAssertEqual(first?.coat?.rawValue, "Short")
        XCTAssertEqual(last?.name, "Midnight")
        XCTAssertEqual(last?.age.rawValue, "Adult")
        XCTAssertEqual(last?.gender.rawValue, "Female")
        XCTAssertEqual(last?.size.rawValue, "Large")
        XCTAssertEqual(last?.coat, nil)
    }
}
