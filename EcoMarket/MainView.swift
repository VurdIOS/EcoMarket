//
//  MainView.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 11.12.2023.
//

import UIKit

class MainView: UIViewController {
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    private let collectionsImages = [
        UIImageView(image: UIImage(named: "CategoryCardFruits")),
        UIImageView(image: UIImage(named: "CategoryCardDryFruits")),
        UIImageView(image: UIImage(named: "CategoryCardVegetables")),
        UIImageView(image: UIImage(named: "CategoryCardGrass")),
        UIImageView(image: UIImage(named: "CategoryCardDrinks")),
        UIImageView(image: UIImage(named: "CategoryCardMilk"))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .MainBackgroundColor
        collectionView.register(
            TypeProductsCollectionViewCell.self,
            forCellWithReuseIdentifier: TypeProductsCollectionViewCell.id
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        setupNavigationController()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func setupNavigationController() {
        title = "Эко Маркет"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "TTNormsPro-Bold", size: 24)!
        ]
    }
}
extension MainView: UICollectionViewDelegate {
    
}
extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO - do not hardcoding
        collectionsImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TypeProductsCollectionViewCell.id,
            for: indexPath
        )
        cell.backgroundView = collectionsImages[indexPath.item]
        return cell
    }
}
extension MainView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (((view.frame.size.width/2.1))*0.9222) , height: (view.frame.size.width/2.1))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
    }
}
