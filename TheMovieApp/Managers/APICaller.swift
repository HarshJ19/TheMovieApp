//
//  APICaller.swift
//  TheMovieApp
//
//  Created by Harsh on 25/04/23.
//

import Foundation
import Alamofire

class APICaller {
    
    static let shared = APICaller()
    
    func getMovieGenres(completion: @escaping (Result<[Genre],Error>) -> Void) {
        
        guard let url = URL(string: Constants.getGenres) else {return}
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { data, response, error in
           
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieGenreResponse.self, from: data)
                completion(.success(results.genres))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getMoviesForGenre(genreId: String,pageNumber : Int,completion: @escaping (Result<MoviesForGenreResponse,Error>) -> Void) {
        
        guard let url = URL(string: Constants.getMovies(genreID: genreId, pageNUmber: pageNumber)) else {return}
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let result = try JSONDecoder().decode(MoviesForGenreResponse.self, from: data)
                completion(.success(result))
            } catch let error1 {
                completion(.failure(error1))
                print(error1)
            }
            
        }
        task.resume()
    }
    
    func getMoviesInfo(movieId: String,completion: @escaping (Result<MovieInfoResponse,Error>) -> Void) {
        
        guard let url = URL(string: Constants.getMovieInfo(movieId: movieId)) else {return}
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let result = try JSONDecoder().decode(MovieInfoResponse.self, from: data)
                completion(.success(result))
            } catch let error1 {
                print(error1)
            }
            
        }
        task.resume()
    }
    
    func getReviews(movieId: String,pageNumber : Int,completion: @escaping (Result<MovieReviewsResponse,Error>) -> Void) {
        
        guard let url = URL(string: Constants.getReviews(movieID: movieId, pageNUmber: pageNumber)) else {return}
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let result = try JSONDecoder().decode(MovieReviewsResponse.self, from: data)
                completion(.success(result))
            } catch let error1 {
                completion(.failure(error1))
                print(error1)
            }
            
        }
        task.resume()
    }
    
}

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}

enum APIError: Error {
    case failedToGetData
}
