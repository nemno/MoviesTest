//
//  Movie.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

struct Movie: Identifiable, Codable, Equatable {
    struct Image: Codable, Equatable {
        let small: String
        let large: String
    }

    let id: String
    let title: String
    var genres: String
    let overView: String
    let image: Image
    let popularity: Float
    var isMarked: Bool
    let genreIds: [Int]

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case genres
        case overView = "overview"
        case image
        case popularity = "vote_average"
        case genreIds = "genre_ids"
    }

    private enum ImageKeys: String, CodingKey {
        case posterPath = "poster_path"
    }

    init(id: String, title: String, genres: String, overView: String, image: Image, popularity: Float, isMarked: Bool) {
        self.id = id
        self.title = title
        self.genres = genres
        self.overView = overView
        self.image = image
        self.popularity = popularity
        self.isMarked = isMarked
        self.genreIds = []
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        overView = try container.decode(String.self, forKey: .overView)
        popularity = try container.decode(Float.self, forKey: .popularity)
        genres = ""
        let imageContainer = try decoder.container(keyedBy: ImageKeys.self)
        let posterPath: String = try imageContainer.decode(String.self, forKey: .posterPath)
        image = Image(small: Constants.smallImageBaseURL + posterPath, large: Constants.largeImageBaseURL + posterPath)
        isMarked = false
        genreIds = try container.decode([Int].self, forKey: .genreIds)

        do {
            id = try String(container.decode(Int.self, forKey: .id))
        } catch DecodingError.typeMismatch {
            throw DecodingError.typeMismatch(Movie.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type"))
        }
    }
}

private extension Movie {
    enum Constants {
        static let smallImageBaseURL = "https://image.tmdb.org/t/p/w185/"
        static let largeImageBaseURL = "https://image.tmdb.org/t/p/w500/"
    }
}
