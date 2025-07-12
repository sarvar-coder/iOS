//
//  AccesTokenManagerTests.swift
//  PetSaveTests
//
//  Created by Sarvar Boltaboyev on 12/07/25.
//

import XCTest
@testable import PetSave

class AccesTokenManagerTests: XCTestCase {
    private var accesTokenManager: AccessTokenManagerProtocol?
    let token = AccessTokenTestHelper.randomAPIToken()
    
    override func setUp() {
        super.setUp()
        
        guard let userDefaults = UserDefaults(suiteName: #file) else { return }
        
        userDefaults.removePersistentDomain(forName: #file)
        
        userDefaults.setValue(token.expiresAt.timeIntervalSince1970, forKey: AppUserDefaultsKeys.expiresAt)
        userDefaults.setValue(token.bearerAccessToken, forKey: AppUserDefaultsKeys.bearerAccessToken)
        
        accesTokenManager = AccessTokenManager(userDefaults: userDefaults)
    }
    
   func testRequestToken() {
       guard let token = accesTokenManager?.fetchToken() else  {
           XCTFail("Didn't get token from the access token manager")
           return
       }
       
       XCTAssertTrue(!token.isEmpty)
    }
    
    func testCachedToken() {
        guard let sameToken = accesTokenManager?.fetchToken() else  {
            XCTFail("Didn't get token from the access token manager")
            return
        }
        
        XCTAssertEqual(sameToken, token.bearerAccessToken)
    }
    
    func testRefreshToken() throws {
        let newToken = AccessTokenTestHelper.randomAPIToken()
        
        
        
        guard let accesTokenManager = accesTokenManager else {
          XCTFail("Access token manager object is nil")
          return
        }
        
        try accesTokenManager.refreshWith(apiToken: newToken)
        XCTAssertNotEqual(token.bearerAccessToken, accesTokenManager.fetchToken())
        XCTAssertEqual(newToken.bearerAccessToken, accesTokenManager.fetchToken())

    }
}
