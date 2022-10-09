//
//  MovieListServiceInterface.swift
//  Movies
//
//  Created by Nemes Norbert on 2022. 10. 06..
//

import Foundation

protocol MovieListServiceInterface {
    func fetchMovieList(completion: @escaping (Result<[Movie], MoviesListError>) -> Void)
    func fetchGenres(completion: @escaping (Result<[Genre], MoviesListError>) -> Void)
}
