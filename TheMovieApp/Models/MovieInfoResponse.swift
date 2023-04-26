//
//  MovieInfoResponse.swift
//  TheMovieApp
//
//  Created by Harsh on 25/04/23.
//

import Foundation

struct MovieInfoResponse: Codable {
    let poster_path: String?
    let overview: String?
    let original_title: String?
    let status: String?
    let vote_count: Int?
}

