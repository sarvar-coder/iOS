//
// RequestManager.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 12/07/25.
//

import Foundation
protocol RequestManagerProtocol {
    func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T
}

class RequestManager: RequestManagerProtocol {
    
    let apiManager: APIManagerProtocol
    let parser: DataParserProtocol
    let accessTokenManager: AccessTokenManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager(),
         parser: DataParserProtocol = DataParser(),
         accessTokenManager: AccessTokenManagerProtocol = AccessTokenManager()
    ) {
        self.apiManager = apiManager
        self.parser = parser
        self.accessTokenManager = accessTokenManager
    }
    
    func requestAccessToken() async throws -> String {
        // 1
        if accessTokenManager.isTokenValid() {
            return accessTokenManager.fetchToken()
        }
        // 2
        let data = try await apiManager.requestToken()
        let token: APIToken = try parser.parse(data: data)
        // 3
        try accessTokenManager.refreshWith(apiToken: token)
        return token.bearerAccessToken
    }
    
    func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T {
        
        let authToken = try await requestAccessToken()
        let data = try await apiManager.perform(request, authToken: authToken)
        
        let decoded: T = try parser.parse(data: data)
        
        return decoded
    }
}
