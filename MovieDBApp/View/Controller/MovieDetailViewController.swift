//
//  MovieDetailViewController.swift
//  MovieDBApp
//
//  Created by CEPL on 10/06/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageName.back.rawValue), for: .normal)
        button.clipsToBounds = true
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView,label])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setMovieData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func goBackToMovieListViewController() {
        self.navigationController?.dismiss(animated: true)
    }
    
    private func configureView() {
        
        view.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 54, paddingLeft: 16, paddingBottom: 16, paddingRight: 16, width: view.frame.size.width, height: view.frame.size.height, enableInsets: false)
        
        view.backgroundColor = .white
        backButton.frame = CGRect(x: 8, y: 16, width: 30, height: 30)
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(goBackToMovieListViewController), for: .touchUpInside)
        view.bringSubviewToFront(backButton)
    }
    
    private func setMovieData() {
        
        guard let imagePath = UserDefaults.standard.value(forKey: UserdefaultKey.path.rawValue) , let overview = UserDefaults.standard.value(forKey: UserdefaultKey.description.rawValue) else { return }
        imageView.setImage(withImageId: imagePath as? String ?? "", placeholderImage: nil, size: .original)
        label.text = overview as? String
    }
}
