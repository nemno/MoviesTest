//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

class MoviesScreenViewModel: MoviesScreenViewModelProtocol {
    @Published var movies: [Movie] = []
    @Published var gernres: [Genre] = []

    private let moviesListService: MovieListServiceInterface

    init(moviesListService: MovieListServiceInterface) {
        self.moviesListService = moviesListService
    }

    func fetchMovies() {
        // TODO: Consider to use Combine or RxSwift to handle these types of problems
        let dispatchGroup = DispatchGroup()
        var responseMovies: [Movie] = []
        var responseGenres: [Genre] = []

        dispatchGroup.enter()
        self.moviesListService.fetchGenres { result in
            if case .success(let genres) = result {
                responseGenres = genres
                dispatchGroup.leave()
            } else {
                // TODO: Handle error
            }
        }

        dispatchGroup.enter()
        self.moviesListService.fetchMovieList { result in
            if case .success(let movies) = result {
                responseMovies = movies
                self.movies = movies
                dispatchGroup.leave()
            } else {
                // TODO: Handle error
            }
        }

        dispatchGroup.notify(queue: .main) {
            for movieIndex in 0..<responseMovies.count {
                let genresString = responseGenres.filter { genre in
                    return responseMovies[movieIndex].genreIds.contains(genre.id)
                }.stringValue()
                responseMovies[movieIndex].genres = genresString
            }
            self.movies = responseMovies
        }
    }
}
