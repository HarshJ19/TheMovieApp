//
//  MovieGenreResponse.swift
//  TheMovieApp
//
//  Created by Harsh on 25/04/23.
//

import Foundation

struct MovieGenreResponse: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
