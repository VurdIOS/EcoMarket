//
//  MainView.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 11.12.2023.
//

import UIKit

class MainView: UIViewController {
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(
            TypeProductsCollectionViewCell.self,
            forCellWithReuseIdentifier: TypeProductsCollectionViewCell.id
        )
        return collectionView
    }()
    private let net = NetworkManager.shared

    var products: [ProductCategory] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .MainBackgroundColor
        
        fetchProductCategories()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        setupNavigationController()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    private func fetchProductCategories() {
        net.fetchProductsCategories { [self] result in
            switch result {
            case .success(let products):
                self.products = products
                collectionView.reloadData()
                print("fetch categories done")
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
        ) as! TypeProductsCollectionViewCell
        cell.Data = products[indexPath.item]
        
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
