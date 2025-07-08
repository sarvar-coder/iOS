//
//  Pagination.swift
//  PetSave
//
//  Created by Sarvar Boltaboyev on 08/07/25.
//

import Foundation

struct Pagination: Codable {
    let countPerPage: Int
    let totalCount: Int
    let currentPage: Int
    let totalPages: Int
}
