//
//  AuthTokenRequest.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 12/07/25.
//

import Foundation

enum AuthTokenRequest: RequestProtocol {
    case auth
    
    var path: String {
        "/v2/oauth2/token"
    }
    
    var requestType: RequestType {
        .POST
    }
    
    var params: [String: Any] {
        [
            "grant_type": APIConstants.grantType,
            "client_id": APIConstants.clientId,
            "client_secret": APIConstants.clientSecret,
        ]
    }
    
    var addAuthorizationToken: Bool {
        false
    }
}
