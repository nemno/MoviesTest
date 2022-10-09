//
//  Array+GenresString.swift
//  Movies
//
//  Created by Nemes Norbert on 2022. 10. 09..
//

import Foundation

extension Array where Element == Genre {
    func stringValue() -> String {
        return self.map { (genre: Genre) -> String in
            return genre.name
        }.joined(separator: ", ")
    }
}
