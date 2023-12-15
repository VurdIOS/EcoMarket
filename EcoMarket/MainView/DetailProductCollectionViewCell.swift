//
//  DetailProductCollectionViewCell.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 14.12.2023.
//

import UIKit

class DetailProductCollectionViewCell: UICollectionViewCell {
    static let id = "DetailProductCollectionViewCell"
    
    var Data: Product? {
        didSet {
            guard let Data = Data else {
                print("Huyayaa")
                return }
            productName.text = Data.title
            productCost.text = "\(Data.price.components(separatedBy: ".")[0]) c"
            print("Данные поступили в ячейку")
            let url = URL(string: Data.image)
            imageView.kf
                .setImage(with: url)
        }
    }

    private let productName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "TTNormsPro-Bold", size: 14)
        lbl.numberOfLines = 0
        
        return lbl
    }()
    private let productCost: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "TTNormsPro-Bold", size: 20)
        lbl.textColor = .AccentColor
        
        return lbl
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 100
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = false
        contentView.backgroundColor = .CollectionCellBackgroundColor
        
        


        contentView.addSubview(imageView)
        contentView.addSubview(productName)
        contentView.addSubview(productCost)
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.421).isActive = true
        productName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        productName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        productName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        productCost.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        productCost.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 20).isActive = true
        productName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        
                
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
