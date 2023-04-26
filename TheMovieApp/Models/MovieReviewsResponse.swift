//
//  MovieReviewsResponse.swift
//  TheMovieApp
//
//  Created by Harsh on 26/04/23.
//

import Foundation

struct MovieReviewsResponse: Codable {
    let id: Int
    let page: Int
    let results: [Review]
    let total_pages: Int
    let total_results: Int
}

struct Review: Codable {
    let author: String?
    let rating: Double?
    let content: String?
}
