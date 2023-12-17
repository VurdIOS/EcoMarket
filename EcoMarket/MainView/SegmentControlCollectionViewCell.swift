//
//  SegmentControlCollectionViewCell.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 17.12.2023.
//

import UIKit

//protocol DetailProductCollectionViewCellDelegate: AnyObject {
////    var orderedProducts: [Product] { get set }
//    func append(products: Product)
//    func minus(products: Product)
//}

class SegmentControlCollectionViewCell: UICollectionViewCell {
    static let id = "SegmentControlCollectionViewCell"

//    weak var delegate: DetailProductCollectionViewCellDelegate?
    var data: String? {
        didSet {
            print("Пришла инфа в ячейку")
            segmentControl.text = data
        }
    }
    


    let segmentControl: UILabel = {
       let btn = UILabel()
        btn.backgroundColor = .AccentColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 24
        
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupTargetsForButtons()
        contentView.addSubview(segmentControl)
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: contentView.topAnchor),
            segmentControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            segmentControl.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            segmentControl.rightAnchor.constraint(equalTo: contentView.rightAnchor)
            
        ])
        contentView.clipsToBounds = false
        contentView.backgroundColor = .CollectionCellBackgroundColor

    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        imageView.image = nil
    }
    
//    private func setupTargetsForButtons() {
//        buttonPlus.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
//        buttonMinus.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
//        buttonAdd.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
//    }

}

