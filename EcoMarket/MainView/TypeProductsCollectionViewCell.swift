//
//  TypeProductsCollectionViewCell.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 11.12.2023.
//

import UIKit
import Kingfisher

class TypeProductsCollectionViewCell: UICollectionViewCell {
    static let id = "TypeProductsCollectionViewCell"
    
    var Data: ProductCategory? {
        didSet {
            guard let Data = Data else { return }
            categoriesName.text = Data.name
            let url = URL(string: Data.image)
            imageView.kf
                .setImage(with: url)
        }
    }

    private let categoriesName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "TTNormsPro-Bold", size: 20)
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    var gradientView: UIView = {
        let uiview = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        uiview.translatesAutoresizingMaskIntoConstraints = false
        

        let gradient = CAGradientLayer()
        gradient.frame = uiview.bounds
        let startColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8).cgColor
        gradient.colors = [UIColor.clear.cgColor, startColor]
        uiview.layer.insertSublayer(gradient, at: 0)
        
        
        return uiview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = false
        imageView.addSubview(gradientView)
        gradientView.addSubview(categoriesName)
        contentView.addSubview(imageView)
        categoriesName.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 10).isActive = true
//        categoriesName.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -30).isActive = true
        categoriesName.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20).isActive = true
        categoriesName.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
                
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        gradientView.frame = imageView.bounds
        categoriesName.frame = gradientView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
