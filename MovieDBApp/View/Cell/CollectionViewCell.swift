//
//  CollectionViewCell.swift
//  MovieDBApp
//
//  Created by CEPL on 31/05/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var imageHorizonatalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView])
        stack.axis = .horizontal
        return stack
        
    }()
    
    private lazy var labelHorizonatalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label])
        stack.axis = .horizontal
        return stack
        
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageHorizonatalStackView,labelHorizonatalStackView])
        stack.axis = .vertical
        stack.spacing = 44
        return stack
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    private func addViews(){
        
        contentView.addSubview(verticalStackView)
        verticalStackView.frame = contentView.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(path: String, title: String) {
        DispatchQueue.main.async {
            self.imageView.setImage(withImageId: path, placeholderImage: nil, size: .original)
            self.label.text = title
        }
        imageView.contentMode = .scaleAspectFill
    }
}
