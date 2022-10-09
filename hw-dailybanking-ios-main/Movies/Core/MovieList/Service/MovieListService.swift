//
//  MovieListService.swift
//  Movies
//
//  Created by Nemes Norbert on 2022. 10. 06..
//

import Foundation

final class MovieListService: MovieListServiceInterface {
    private let apiService: APIServiceInterface

    init(apiService: APIServiceInterface) {
        self.apiService = apiService
    }

    func fetchMovieList(completion: @escaping (Result<[Movie], MoviesListError>) -> Void) {
        apiService.GET(endpoint: .trendingList, params: nil) { (result: Result<PaginatedResponse<Movie>, APIError>) in

            if case .success(let moviesPaginatedResponse) = result {
                completion(.success(moviesPaginatedResponse.results))
            } else {
                completion(.failure(MoviesListError.general))
            }
        }
    }

    func fetchGenres(completion: @escaping (Result<[Genre], MoviesListError>) -> Void) {
        apiService.GET(endpoint: Endpoint.genres, params: nil) { (result: Result<GenreListResponse,
            APIError>) in
            if case .success(let genresResponse) = result {
                completion(.success(genresResponse.genres))
            } else {
                completion(.failure(MoviesListError.general))
            }
        }
    }
}
