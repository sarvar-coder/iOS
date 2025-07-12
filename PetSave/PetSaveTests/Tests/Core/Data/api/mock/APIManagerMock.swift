//
//  APIManagerMock.swift
//  PetSaveTests
//
//  Created by Sarvar Boltaboyev on 12/07/25.
//

import Foundation
// 1
@testable import PetSave
// 2
struct APIManagerMock: APIManagerProtocol {
    // 3
    func perform(_ request: RequestProtocol, authToken: String) async
    throws -> Data {
        return try Data(contentsOf: URL(fileURLWithPath: request.path),
                        options: .mappedIfSafe)
    }
    // 4
    func requestToken() async throws -> Data {
        Data(AccessTokenTestHelper.generateValidToken().utf8)
    }
}
