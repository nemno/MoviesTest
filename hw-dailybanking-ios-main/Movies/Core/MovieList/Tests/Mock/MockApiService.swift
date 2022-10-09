//
//  MockApiService.swift
//  Movies
//
//  Created by Nemes Norbert on 2022. 10. 07..
//

import Foundation

final class MockApiService: APIServiceInterface {
    var mockResponseObject: PaginatedResponse<Movie>?

    func GET<T>(endpoint: Endpoint, params: [String : String]?, completionHandler: @escaping (Result<T, APIError>) -> Void) where T : Decodable, T : Encodable {
        if let responseObject = mockResponseObject {
            completionHandler(Result<PaginatedResponse<Movie>, APIError>.success(responseObject) as! Result<T, APIError>)
        } else {
            completionHandler(.failure(.noResponse))
        }
    }
}
