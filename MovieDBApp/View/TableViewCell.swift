//
//  SampleTableViewCell.swift
//  SampleApp
//
//  Created by CEPL on 31/05/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    private var title = ""
    private var movieType: MovieType = .popular
    
    
    var popularMovieItem: [PopularMovie]?
    var upcomingMovieItem: [UpcomingMovie]?
    
    private let titleLabel : UILabel =  {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .gray
        return label
        
    }()
    
    private let collectionView :UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeView() {
        //MARK: REgister CollectionViewcell inside TableView
        registerNibs()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel,collectionView])
        stackView.distribution = .equalCentering
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 8
        contentView.addSubview(stackView)
        
        //MARK: set Programatically constaraints
        
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: frame.size.width, height: 24, enableInsets: false)
        collectionView.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width, height: 70, enableInsets: false)
        
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 70, enableInsets: false)
    }
    
    func configureCell(type: MovieType, movieCategory: String, popularMovie: [PopularMovie]? ,upcomingMovie: [UpcomingMovie]? ) {
        titleLabel.text = movieCategory
        movieType = type
        popularMovieItem = popularMovie
        upcomingMovieItem = upcomingMovie
        collectionView.reloadData()
    }
    
    func registerNibs() {
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: Identifier.CollectionViewCell.rawValue)
    }
}

//MARK: CollectionView functions

extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch movieType {
        case .popular:
            if let cell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.CollectionViewCell.rawValue, for: indexPath) as? CollectionViewCell, let imagePath = popularMovieItem?[indexPath.row].posterPath, let movieTitle = popularMovieItem?[indexPath.row].title {
                cell.configureCell(path: imagePath, title: movieTitle)
                return cell
            }
            return UICollectionViewCell()
            
        case .upcoming:
            if let cell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.CollectionViewCell.rawValue, for: indexPath) as? CollectionViewCell, let imagePath = upcomingMovieItem?[indexPath.row].posterPath, let movieTitle = upcomingMovieItem?[indexPath.row].title{
                cell.configureCell(path: imagePath, title: movieTitle)
                return cell
            }
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch movieType {
        case .popular:
            return popularMovieItem?.count ?? 0
        case .upcoming:
            return upcomingMovieItem?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch movieType {
        case .popular:
            return CGSize(width: (13/19) * collectionView.frame.size.height, height: collectionView.frame.size.height)
        case .upcoming:
            return CGSize(width: (13/19) * collectionView.frame.size.height, height: collectionView.frame.size.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
