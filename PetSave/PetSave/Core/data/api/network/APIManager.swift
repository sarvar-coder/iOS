//
//  APIManager.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 12/07/25.
//

import Foundation
protocol APIManagerProtocol {
    func perform(_ request: RequestProtocol, authToken: String) async throws -> Data
    func requestToken() async throws -> Data
}


class APIManager: APIManagerProtocol {
    
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func perform(_ request: RequestProtocol, authToken: String = "") async throws -> Data {
        
        let (data, response) = try await urlSession.data(for: request.createURLRequest(authToken: authToken))

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else { throw NetworkError.invalidServerResponse }
        
        return data
    }
    
    func requestToken() async throws -> Data {
        try await perform(AuthTokenRequest.auth)
    }
}
