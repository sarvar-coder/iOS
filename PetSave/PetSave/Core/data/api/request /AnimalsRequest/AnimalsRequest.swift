//
//  AnimalsRequest.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 12/07/25.
//

import Foundation

//enum AnimalsRequest: RequestProtocol {
//    case getAnimalsWith(page: Int, lat: Double?, long: Double?)
//    case getAnimalsBy(name: String, age: String?, type: String?)
//    
//    var path: String {
//        "/v2/animals"
//    }
//    
//    var requestType: RequestType {
//        .GET
//    }
//    
//    var urlParams: [String : String?] {
//        switch self {
//        case .getAnimalsWith(let page, let lat, let long):
//            var params = ["page": String(page)]
//            
//            if let lat = lat {
//                params["latitude"] = String(lat)
//            }
//            
//            if let long = long  {
//                params["longitude"] = String(long)
//            }
//            params["sort"] = "random"
//            
//            return params
//        case .getAnimalsBy(let name, let age, let type):
//            var params: [String: String] = [:]
//            if !name.isEmpty {
//              params["name"] = name
//            }
//            
//            if let age {
//                params["age"] = age
//            }
//            
//            if let type {
//                params["type"] = type 
//            }
//            
//            return params
//        }
//    }
//}

enum AnimalsRequest: RequestProtocol {
  case getAnimalsWith(page: Int, latitude: Double?, longitude: Double?)
  case getAnimalsBy(name: String, age: String?, type: String?)

  var path: String {
    "/v2/animals"
  }

  var urlParams: [String: String?] {
    switch self {
    case let .getAnimalsWith(page, latitude, longitude):
      var params = ["page": String(page)]
      if let latitude = latitude {
        params["latitude"] = String(latitude)
      }

      if let longitude = longitude {
        params["longitude"] = String(longitude)
      }
      params["sort"] = "random"
      return params

    case let .getAnimalsBy(name, age, type):
      var params: [String: String] = [:]
      if !name.isEmpty {
        params["name"] = name
      }

      if let age = age {
        params["age"] = age
      }

      if let type = type {
        params["type"] = type
      }
      return params
    }
  }

  var requestType: RequestType {
    .GET
  }
}
