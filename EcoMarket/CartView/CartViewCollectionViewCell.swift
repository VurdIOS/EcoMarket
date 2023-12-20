//
//  CartViewCollectionViewCell.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 19.12.2023.
//

import UIKit

class CartViewCollectionViewCell: UICollectionViewCell {
    static let id = "CartViewCollectionViewCell"
    
    private var amountProduct = 0 {
        didSet {
            amountLabel.text = String(amountProduct)
        }
    }
    
    var Data: Product? {
        didSet {
            guard let Data = Data else {
                return }
            let cost = Data.price.components(separatedBy: ".")[0]
            productNameLabel.text = Data.title
            productCost.text = "\(cost) c"
            productDiscription.text = "Цена \(cost) за шт"
            amountProduct = Data.quantity
            let url = URL(string: Data.image)
            imageView.kf
                .setImage(with: url)
        }
    }
    
    private let productNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "TTNormsPro-Bold", size: 14)
        lbl.numberOfLines = 0
        
        return lbl
    }()
    

    
    private let productDiscription: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .greyForBorders
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "TTNormsPro-Bold", size: 12)
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let buttonMinus: UIButton = {
        let btn = UIButton()
        btn.setTitle("-", for: .normal)
        btn.backgroundColor = .AccentColor
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }()
    
    private let buttonPlus: UIButton = {
        let btn = UIButton()
        btn.setTitle("+", for: .normal)
        btn.backgroundColor = .AccentColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    private let deleteButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "TrashIcon"), for: .normal)
        btn.backgroundColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    private lazy var amountLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = String(amountProduct)
        lbl.textAlignment = .center
        
        return lbl
        
    }()
    private let HStackAmountBlock: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = 16.0
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTargetsForButtons()
        contentView.clipsToBounds = false
        contentView.backgroundColor = .CollectionCellBackgroundColor
        HStackAmountBlock.addArrangedSubview(buttonMinus)
        HStackAmountBlock.addArrangedSubview(amountLabel)
        HStackAmountBlock.addArrangedSubview(buttonPlus)

        contentView.addSubview(imageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productDiscription)
        contentView.addSubview(productCost)
        contentView.addSubview(HStackAmountBlock)
        imageView.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 4),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            imageView.widthAnchor.constraint(equalToConstant: 98)
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 2),
            deleteButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -2),
            deleteButton.widthAnchor.constraint(equalToConstant: 32),
            deleteButton.heightAnchor.constraint(equalToConstant: 32)
        ])
        NSLayoutConstraint.activate([
            productNameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            productNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            productNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4)
        ])
        NSLayoutConstraint.activate([
            productDiscription.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            productDiscription.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 4)
        ])
        NSLayoutConstraint.activate([
            productCost.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            productCost.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            
        ])
        NSLayoutConstraint.activate([
            HStackAmountBlock.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4),
            HStackAmountBlock.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            HStackAmountBlock.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
            HStackAmountBlock.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Пздц какой кошмар, над переделать
        buttonPlus.frame.size.width = 24
        buttonPlus.frame.size.height = 24
        buttonMinus.frame.size.width = 24
        buttonMinus.frame.size.height = 24
        buttonPlus.layer.cornerRadius = 15
        buttonMinus.layer.cornerRadius = 15
        deleteButton.layer.cornerRadius = 6
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    private func setupTargetsForButtons() {
        buttonPlus.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        buttonMinus.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    @objc func deleteButtonTapped() {
        
        
    }
    
    
    @objc func plusButtonTapped() {
        if amountProduct >= 1 {
            amountProduct += 1
        }
    }
    
    @objc func minusButtonTapped() {
        if amountProduct == 1 {
            amountProduct -= 1
        } else if amountProduct >= 1 {
            amountProduct -= 1
        }
    }
}


