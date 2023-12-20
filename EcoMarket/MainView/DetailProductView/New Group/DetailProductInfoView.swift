//
//  DetailProductInfoView.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 20.12.2023.
//

import UIKit

class DetailProductInfoView: UIViewController {
    
    var product: Product! {
        didSet {
            titleLabel.text = product.title
            costLabel.text = (product.price.components(separatedBy: ".")[0])
            descriptionLabel.text = product.description
            
            
            let url = URL(string: product.image)
            imageView.kf
                .setImage(with: url)
        }
    }
    var imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.layer.cornerRadius = 12
        return img
    }()
    
    var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "TTNormsPro-Bold", size: 24)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    var costLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "TTNormsPro-Bold", size: 24)
        lbl.textColor = .AccentColor
        return lbl
    }()
    
    var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .greyForBorders
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "TTNormsPro-Medium", size: 16)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    var addButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Добавить", for: .normal)
        btn.backgroundColor = .AccentColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 12
        
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(costLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 208)
        
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 48)
        
        ])
        
        NSLayoutConstraint.activate([
            costLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            costLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            costLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            costLabel.heightAnchor.constraint(equalToConstant: 24)
        
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: costLabel.bottomAnchor, constant: 8),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 76)
        
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            addButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 54)
        
        ])
        
        

        // Do any additional setup after loading the view.
    }
    override func updateViewConstraints() {
 
        view.frame.size.height = 600
        view.frame.origin.y = UIScreen.main.bounds.height - 400 - 200
        super.updateViewConstraints()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
