//
//  Data+PrettyPrinted.swift
//  Movies
//
//  Created by Nemes Norbert on 2022. 10. 07..
//

import Foundation

extension Data {
    func formatedJSONString() -> String? {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            return String(decoding: jsonData, as: UTF8.self)
        }

        return nil
    }
}
