//
//  APIServiceInterface.swift
//  Movies
//
//  Created by Nemes Norbert on 2022. 10. 07..
//

import Foundation

public enum APIError: Error {
    case noResponse
    case jsonDecodingError(error: Error)
    case networkError(error: Error)
}

public enum Endpoint {
    case trendingList
    case genres

    func path() -> String {
        switch self {
        case .trendingList:
            return "trending/movie/day"
        case .genres:
            return "genre/movie/list"
        }
    }
}

protocol APIServiceInterface {
    func GET<T: Codable>(endpoint: Endpoint, params: [String: String]?, completionHandler: @escaping (Result<T, APIError>) -> Void)
}
