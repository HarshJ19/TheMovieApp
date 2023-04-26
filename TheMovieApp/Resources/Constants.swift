//
//  Constants.swift
//  TheMovieApp
//
//  Created by Harsh on 25/04/23.
//

import Foundation

class Constants {
    
    static let API_KEY = PLEASE ADD API KEY HERE SHARED IN THE EMAIL
    
    static let baseURL = "https://api.themoviedb.org"
    
    // URLs
    static let queryString = "?api_key=\(API_KEY)&language=en-US"
    static let getGenres = "\(baseURL)/3/genre/movie/list\(queryString)"

    static func getReviews(movieID: String,pageNUmber : Int) -> String {
        return "\(baseURL)/3/movie/\(movieID)/reviews\(queryString)&page=\(pageNUmber)"
    }
    
    static func getMovies(genreID : String, pageNUmber : Int) -> String {
        return "\(baseURL)/3/discover/movie\(queryString)&with_genres=\(genreID)&page=\(pageNUmber)"
    }

    static func getMovieInfo(movieId: String) -> String {
        return "\(baseURL)/3/movie/\(movieId)\(queryString)"
    }
    
    
    
    static let baseImageURL = "https://image.tmdb.org/t/p/w500/"
    
    // ViewController identifiers
    struct VC {
        static let MovieGenresListViewControllerIdentifier = "MovieGenresListViewController"
        static let MoviesListViewControllerIdentifier = "MoviesListViewController"
        static let MovieInfoViewControllerIdentifier = "MovieInfoViewController"
        static let ReviewsViewControllerIdentifier = "ReviewsViewController"
    }
    
}
//
