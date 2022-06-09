//
//  ViewController.swift
//  MovieDBApp
//
//  Created by CEPL on 09/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    let popularViewModel = PopularMovieViewModel()
    let upcomingViewModel = UpcomingMovieViewModel()
    private var popularMovie: [PopularMovie]?
    private var upcomingMovie: [UpcomingMovie]?
    let tableView = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPopularMovieList()
        fetchUpcomingMovieList()
        setupTableView()
    }
    
    func fetchPopularMovieList() {
        popularViewModel.delegate = self
        popularViewModel.fetchPopularMovieList()
    }
    
    func fetchUpcomingMovieList() {
        upcomingViewModel.delegate = self
        upcomingViewModel.fetchUpcomingMovieList()
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: Identifier.TableViewCell.rawValue)
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: Identifier.TableViewCell.rawValue) as? TableViewCell , let type = MovieType(rawValue: indexPath.row) {
            switch type {
            case .popular:
                guard let movie = popularMovie else { return UITableViewCell()}
                //cell.configureCell(type: type, movie: movie)
                cell.configureCell(type: type, popularMovie: movie, upcomingMovie: nil)
                return cell
            case .upcoming:
                guard let movie = upcomingMovie else { return UITableViewCell()}
                cell.configureCell(type: type, popularMovie: nil, upcomingMovie: movie)
                //cell.configureCell(type: type, movie: movie)
                return cell
            }
           
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 344
    }
}

extension ViewController: PopularMovieViewModelProtocol, UpcomingMovieViewModelProtocol {
    
    func didReceivePopularMovieList(response: [PopularMovie]?) {
        popularMovie = response
        tableView.reloadData()
    }
    
    func didReceiveUpcomingMovieList(response: [UpcomingMovie]?) {
        upcomingMovie = response
        tableView.reloadData()
    }
    
}
