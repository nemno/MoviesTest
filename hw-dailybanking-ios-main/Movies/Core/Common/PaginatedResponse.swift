//
//  PaginatedResponse.swift
//  Movies
//
//  Created by Nemes Norbert on 2022. 10. 06..
//

import Foundation

struct PaginatedResponse<T: Codable>: Codable {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: [T]
}
