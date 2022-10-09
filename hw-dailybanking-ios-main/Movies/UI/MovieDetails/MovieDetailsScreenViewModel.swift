//
//  MovieDetailsScreenViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

class MovieDetailsScreenViewModel: MovieDetailsScreenViewModelProtocol {
    @Published var movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }

    func markMovie() {
        self.movie.isMarked = !self.movie.isMarked
    }
}
