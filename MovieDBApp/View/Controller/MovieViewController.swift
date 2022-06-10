//
//  MovieViewController.swift
//  MovieDBApp
//
//  Created by CEPL on 09/06/22.
//

import UIKit


class MovieViewController: UIViewController {
    
    private let popularViewModel = PopularMovieViewModel()
    private let upcomingViewModel = UpcomingMovieViewModel()
    private var popularMovie: [PopularMovie]?
    private var upcomingMovie: [UpcomingMovie]?
    
    // MARK: UI Component
    private let tableView = UITableView()
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.text = APPName.appName.rawValue
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPopularMovieList()
        fetchUpcomingMovieList()
        setupTableView()
        label.frame = CGRect(x: 0, y: 16, width: UIScreen.main.bounds.width, height: 24)
        view.addSubview(label)
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: Fetch Popular Movies
    private func fetchPopularMovieList() {
        
        popularViewModel.delegate = self
        popularViewModel.fetchPopularMovieList()
    }
    
    // MARK: Fetch Upcoming Movies
    private func fetchUpcomingMovieList() {
        upcomingViewModel.delegate = self
        upcomingViewModel.fetchUpcomingMovieList()
    }
    
    // MARK: Setup tableview
    private func setupTableView() {
        
        tableView.frame = CGRect(x: 0, y: label.frame.size.height + 32, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 32)
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: Identifier.tableViewCell.rawValue)
        tableView.reloadData()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
}

// MARK: TableView DataSource
extension MovieViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: Identifier.tableViewCell.rawValue) as? TableViewCell , let type = MovieType(rawValue: indexPath.row) {
            cell.delegate = self
            switch type {
            case .popular:
                guard let movie = popularMovie else { return UITableViewCell()}
                cell.configureCell(type: type, movieCategory: MovieCategory.popular.rawValue, popularMovie: movie, upcomingMovie: nil)
                return cell
            case .upcoming:
                guard let movie = upcomingMovie else { return UITableViewCell()}
                cell.configureCell(type: type, movieCategory: MovieCategory.upcoming.rawValue, popularMovie: nil, upcomingMovie: movie)
                return cell
            }
        }
        return UITableViewCell()
    }
}

// MARK: TableView Delegate
extension MovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 344
    }
}

// MARK: Popular and upcoming moview delegate
extension MovieViewController: PopularMovieViewModelProtocol, UpcomingMovieViewModelProtocol, movieDataProtocol {
    
    func didReceivePopularMovieList(response: [PopularMovie]?) {
        popularMovie = response
        tableView.reloadData()
    }
    
    func didReceiveUpcomingMovieList(response: [UpcomingMovie]?) {
        upcomingMovie = response
        tableView.reloadData()
    }
    
    func movieData(data: movieData) {
        UserDefaults.standard.set(data.movieDescription, forKey: UserdefaultKey.description.rawValue)
        UserDefaults.standard.set(data.imagePath, forKey: UserdefaultKey.path.rawValue)
        let movieDetailViewController = UINavigationController(rootViewController:  MovieDetailViewController())
        movieDetailViewController.modalPresentationStyle = .fullScreen
        present(movieDetailViewController, animated: true)
    }
}

