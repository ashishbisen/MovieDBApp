//
//  SampleBooksCollectionViewCell.swift
//  SampleApp
//
//  Created by CEPL on 31/05/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    private let imageView : UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    private func addViews(){
        addSubview(imageView)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: frame.size.width / 2, height: 0, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(path: String) {
        DispatchQueue.main.async {
            self.imageView.setImage(withImageId: path, placeholderImage: nil, size: .original)
        }
        imageView.contentMode = .scaleAspectFit
    }
}
