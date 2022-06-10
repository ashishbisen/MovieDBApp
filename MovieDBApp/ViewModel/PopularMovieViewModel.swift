//
//  MovieViewModel.swift
//  MovieDBApp
//
//  Created by CEPL on 09/06/22.
//

import Foundation

protocol PopularMovieViewModelProtocol {
    
    func didReceivePopularMovieList(response: [PopularMovie]?)
}

class PopularMovieViewModel {
    
    //MARK: - Internal Properties
    var delegate: PopularMovieViewModelProtocol?
    
    func fetchPopularMovieList() {
        MovieAPIService.instance.fetchPopularMovies { result in
            switch result {
            case .success(let data):
                let mappedModel = try? JSONDecoder().decode(PopularMovieResponseModel.self, from: data) as PopularMovieResponseModel
                self.delegate?.didReceivePopularMovieList(response: mappedModel?.movie)
                break
            case .failure(let error):
                print(error.description)
            }
        }
    }
}
