//
//  MovieApiService.swift
//  MovieDBApp
//
//  Created by CEPL on 09/06/22.
//


import UIKit

class MovieAPIService: NSObject, Requestable {

    static let instance = MovieAPIService()
   
    public var movies: [PopularMovie]?

    func fetchPopularMovies(callback: @escaping Handler) {
        
        request(method: .get, url: Domain.baseUrl() + APIEndpoint.popularMovies) { (result) in
           callback(result)
        }
    }
    
    func fetchUpcomingMovies(callback: @escaping Handler) {
        request(method: .get, url: Domain.baseUrl() + APIEndpoint.upcomingMovies) { (result) in
           callback(result)
        }
    }
}
