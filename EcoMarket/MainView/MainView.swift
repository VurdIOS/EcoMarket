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
    private let net = NetworkManager.shared
//    var categories: [ProductCategory]!
    var products: [Product] = []{
        didSet {
            print(products.count)
            print("done")
        }
    }
    
    
    
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
        fetchProduct()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        setupNavigationController()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    private func fetchProduct() {
        net.fetchProductsList { [self] result in
            switch result {
            case .success(let products):
                self.products = products
                self.collectionView.reloadData()
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupNavigationController() {
        title = "Эко Маркет"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "TTNormsPro-Bold", size: 24)!
        ]
    }
}
extension MainView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("section is \(indexPath.section), row is \(indexPath.row)")
        let vc = DetailProductCollectionView()
        switch indexPath.row {
        case 0:
            vc.startTypeProduct = Categories.fruits.rawValue
        case 1:
            vc.startTypeProduct = Categories.dryFruits.rawValue
        case 2:
            vc.startTypeProduct = Categories.vegetables.rawValue
        case 3:
            vc.startTypeProduct = Categories.grass.rawValue
        case 4:
            vc.startTypeProduct = Categories.drinks.rawValue
        case 5:
            vc.startTypeProduct = Categories.milks.rawValue
        default:
            vc.startTypeProduct = Categories.all.rawValue
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO - do not hardcoding
        products.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TypeProductsCollectionViewCell.id,
            for: indexPath
        )
        // Короче тут сломались, потому что из за того что я гружу теперь картинки из инета, тут не бьется, нужно изменить ячейку, и начать грузить фотки из интернета, потом все должно заработать.
        cell.backgroundView = products[indexPath.row].image
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
