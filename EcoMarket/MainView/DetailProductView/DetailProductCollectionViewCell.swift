//
//  DetailProductCollectionViewCell.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 14.12.2023.
//

import UIKit

protocol DetailProductCollectionViewCellDelegate: AnyObject {
    func append(products: Product)
    func minus(products: Product)
}

class DetailProductCollectionViewCell: UICollectionViewCell {
    static let id = "DetailProductCollectionViewCell"
    
    private var amountProduct = 0 {
        didSet {
            amountLabel.text = String(amountProduct)
        }
    }
    weak var delegate: DetailProductCollectionViewCellDelegate?
    
    var Data: Product? {
        didSet {
            guard let Data = Data else {
                return }
            productName.text = Data.title
            productCost.text = "\(Data.price.components(separatedBy: ".")[0]) c"
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

        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let buttonMinus: UIButton = {
       let btn = UIButton()
        btn.setTitle("-", for: .normal)
        btn.backgroundColor = .AccentColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 16
        btn.frame.size.width = 32
        btn.frame.size.height = 32
    
        return btn
    }()
    
    private let buttonPlus: UIButton = {
       let btn = UIButton()
        btn.setTitle("+", for: .normal)
        btn.backgroundColor = .AccentColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 16
        btn.frame.size.width = 32
        btn.frame.size.height = 32
        
        return btn
    }()
    
    private let buttonAdd: UIButton = {
       let btn = UIButton()
        btn.setTitle("Добавить", for: .normal)
        btn.backgroundColor = .AccentColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 12
        
        
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
        contentView.addSubview(productName)
        contentView.addSubview(productCost)
        contentView.addSubview(HStackAmountBlock)
        contentView.addSubview(buttonAdd)
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 4).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.421).isActive = true
        productName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4).isActive = true
        productName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4).isActive = true
        productName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4).isActive = true
        productCost.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4).isActive = true
        productCost.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 24).isActive = true

        
        HStackAmountBlock.topAnchor.constraint(equalTo: productCost.bottomAnchor, constant: 16).isActive = true
        HStackAmountBlock.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -8).isActive = true
        HStackAmountBlock.heightAnchor.constraint(equalToConstant: 32).isActive = true
        HStackAmountBlock.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        buttonAdd.topAnchor.constraint(equalTo: productCost.bottomAnchor, constant: 16).isActive = true
        buttonAdd.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -8).isActive = true
        buttonAdd.heightAnchor.constraint(equalToConstant: 32).isActive = true
        buttonAdd.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        HStackAmountBlock.isHidden = true
        
                
        
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
    
    private func setupTargetsForButtons() {
        buttonPlus.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        buttonMinus.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        buttonAdd.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc func plusButtonTapped() {
        if amountProduct >= 1 {
            amountProduct += 1
            delegate?.append(products: Data!)
        }
    }
    
    @objc func minusButtonTapped() {
        if amountProduct == 1 {
            amountProduct -= 1
            delegate?.minus(products: Data!)
            changeHiddenStateOfAmountBlock()
        } else if amountProduct >= 1 {
            amountProduct -= 1
            delegate?.minus(products: Data!)
        }
    }
    
    @objc func addButtonTapped() {
        if amountProduct == 0 {
            amountProduct += 1
            delegate?.append(products: Data!)
            changeHiddenStateOfAmountBlock()
        }
    }
    
    private func changeHiddenStateOfAmountBlock() {
        HStackAmountBlock.isHidden.toggle()
        buttonAdd.isHidden.toggle()
        
    }
    
    
}
