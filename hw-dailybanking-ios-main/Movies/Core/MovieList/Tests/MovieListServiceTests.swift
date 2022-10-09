//
//  MovieListServiceTests.swift
//  MoviesTests
//
//  Created by Nemes Norbert on 2022. 10. 07..
//

import XCTest

@testable import Movies

class MovieListServiceTests: XCTestCase {
    var apiService: MockApiService!
    var sut: MovieListService!

    override func setUpWithError() throws {
        apiService = MockApiService()
        sut = MovieListService(apiService: apiService)
    }

    override func tearDownWithError() throws {
        apiService = nil
        sut = nil
    }
}

extension MovieListServiceTests {
    func testSuccess() throws {
        // Given
        let givenResponseObject = PaginatedResponse<Movie>(page: 0, total_results: 3, total_pages: 1, results: previewMovies)
        apiService.mockResponseObject = givenResponseObject
        let completionExpectation = expectation(description: "Completed")

        // When
        var movies: [Movie]?
        var error: MoviesListError?
        sut.fetchMovieList { (result: Result<[Movie], MoviesListError>) in
            if case .success(let resultMovies) = result {
                movies = resultMovies
            } else {
                error = .general
            }
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)

        // Then
        XCTAssertEqual(movies, givenResponseObject.results)
        XCTAssertNil(error)
    }

    func testError() {
        // Given
        apiService.mockResponseObject = nil
        let completionExpectation = expectation(description: "Completed")

        // When
        var movies: [Movie]?
        var error: MoviesListError?
        sut.fetchMovieList { (result: Result<[Movie], MoviesListError>) in
            if case .success(let resultMovies) = result {
                movies = resultMovies
            } else {
                error = .general
            }
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)

        // Then
        XCTAssertNil(movies)
        XCTAssertNotNil(error)
    }
}
