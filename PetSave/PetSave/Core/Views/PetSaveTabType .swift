//
//  PetSaveTabType .swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 15/07/25.
//

import Foundation

enum PetSaveTabType {
    case nearYou
    case search
    
    static func deepLinkType(url: URL) -> PetSaveTabType {
        if url.scheme == "petsave" {
            switch url.host {
            case "nearYou":
                return .nearYou
            case "search":
                return .search
            default:
                return .nearYou
            }
        }
        return .nearYou
    }
}
