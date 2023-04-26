//
//  MoviesForGenreResponse.swift
//  TheMovieApp
//
//  Created by Harsh on 25/04/23.
//

import Foundation

struct MoviesForGenreResponse: Codable {
    let page: Int
    let results: [Movie]
    let total_pages, total_results: Int
}

// MARK: - Result
struct Movie: Codable {
    let adult: Bool
    let genre_ids: [Int]
    let id: Int
    let original_language: String
    let original_title : String
    let overview: String
    let popularity: Double
    let poster_path : String
    let release_date : String
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}

