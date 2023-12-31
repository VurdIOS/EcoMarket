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

    var products: [ProductCategory] = [] {
        didSet {
            products.sort(by: {$0.id < $1.id})
        }
    }

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
        let vc = DetailProductCollectionView()
        vc.startTypeProduct = indexPath.row + 1
        vc.productsCategories = products
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
