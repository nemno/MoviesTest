//
//  MockViewModels.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

class MockViewModel: MoviesScreenViewModelProtocol {
    func fetchMovies() {}

    var movies: [Movie] = previewMovies
}

class MockMovieDetailsViewModel: MovieDetailsScreenViewModelProtocol {
    let movie: Movie = previewMovies[0]

    func markMovie() {}
}
