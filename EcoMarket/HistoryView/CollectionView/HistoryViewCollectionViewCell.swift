//
//  HistoryViewCollectionViewCell.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 24.12.2023.
//

import UIKit

class HistoryViewCollectionViewCell: UICollectionViewCell {
    static let id = "HistoryViewCollectionViewCell"
    
    
    var data: Order? {
        didSet {
            guard let data = data else {
                return }
            let cost = data.totalAmount.components(separatedBy: ".")[0]
            orderNameLabel.text = "Заказа №\(data.orderNumber)"
            orderCostLabel.text = "\(cost) c"
            orderTimeLabel.text = String(data.createdAt.suffix(5))
            print("инфа пришла в ячейку")
        }
    }
    
    private let orderNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "TTNormsPro-Medium", size: 16)
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    
    
    private let orderTimeLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .greyForBorders
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "TTNormsPro-Medium", size: 14)
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    private let orderCostLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "TTNormsPro-Bold", size: 20)
        lbl.textColor = .AccentColor
        
        return lbl
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "OrderCartIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = false
        contentView.backgroundColor = .CollectionCellBackgroundColor
        
        contentView.addSubview(imageView)
        contentView.addSubview(orderNameLabel)
        contentView.addSubview(orderTimeLabel)
        contentView.addSubview(orderCostLabel)
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 12),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13),
            imageView.widthAnchor.constraint(equalToConstant: 43)
        ])
        
        NSLayoutConstraint.activate([
            orderNameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            orderNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            orderNameLabel.widthAnchor.constraint(equalToConstant: 150),
            orderNameLabel.heightAnchor.constraint(equalToConstant: 19)
        ])
        NSLayoutConstraint.activate([
            orderTimeLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            orderTimeLabel.topAnchor.constraint(equalTo: orderNameLabel.bottomAnchor, constant: 2),
            orderTimeLabel.heightAnchor.constraint(equalToConstant: 17)
        ])
        NSLayoutConstraint.activate([
            orderCostLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
            orderCostLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setup(with: Order) {
        data = with
    }
    
    
    
}
