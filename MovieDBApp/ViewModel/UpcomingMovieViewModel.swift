//
//  UpcomingMovieViewModel.swift
//  MovieDBApp
//
//  Created by CEPL on 09/06/22.
//

import Foundation

protocol UpcomingMovieViewModelProtocol {

    func didReceiveUpcomingMovieList(response: [UpcomingMovie]?)
}

class UpcomingMovieViewModel {

    //MARK: - Internal Properties
    
    var delegate: UpcomingMovieViewModelProtocol?

func fetchUpcomingMovieList() {
    MovieAPIService.instance.fetchUpcomingMovies { result in
        switch result {
        case .success(let data):
            let mappedModel = try? JSONDecoder().decode(UpcomingMovieResponseModel.self, from: data) as UpcomingMovieResponseModel
            print("MOVIE APP: UPCOMING\(mappedModel?.moviewResults.count)")
            self.delegate?.didReceiveUpcomingMovieList(response: mappedModel?.moviewResults)
            break
        case .failure(let error):
            print(error.description)
        }
    }
}
}
