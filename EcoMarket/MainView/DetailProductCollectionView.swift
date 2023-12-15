//
//  DetailProductCollectionView.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 12.12.2023.
//

import UIKit

class DetailProductCollectionView: UIViewController {
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(
            DetailProductCollectionViewCell.self,
            forCellWithReuseIdentifier: DetailProductCollectionViewCell.id
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let segment = UISegmentedControl()
    var startTypeProduct: Int!
    var productsCategories: [ProductCategory] = []
    var products: [Product] = [] {
        didSet {
            print("\(products.count) products")
            checkSegmentedControllerState()
        }
    }
    var sortedProducts: [Product] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    let searchController = UISearchController()
    var segmentedController: UISegmentedControl!
    private let net = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .MainBackgroundColor
        setupNavController()
        setupSearchBar()
        setupSegmentedController()
        setupConstraints()
        fetchProducts()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    // TODO -  СДелать красивее›
    private func checkSegmentedControllerState() {
        var sorted: [Product] = []
        if segmentedController.selectedSegmentIndex == 0 {
            sortedProducts = products
            return
        } else {
            for product in products {
                if product.category == segmentedController.selectedSegmentIndex {
                    sorted.append(product)
                }
            }
        }
        sortedProducts = sorted
    }
    
    private func setupSegmentedController() {
        let items = ["Все", "Фрукты", "Сухофрукты", "Овощи", "Зелень", "Чай кофе", "Молочные продукты"]
        
        segmentedController = UISegmentedControl(items: items)
        segmentedController.addTarget(self, action: #selector(changeState), for: .valueChanged)
        segmentedController.translatesAutoresizingMaskIntoConstraints = false
        segmentedController.selectedSegmentIndex = startTypeProduct
        
        
    }
    @objc func changeState(segmentedControl: UISegmentedControl) {
        checkSegmentedControllerState()
   
    }
    

    private func setupSearchBar() {
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.automaticallyShowsCancelButton = false
        searchController.searchBar.placeholder = "Fast search"
        searchController.searchBar.setImage(UIImage(named: "TabBarHome"), for: .search, state: .normal)
    }
    
    private func setupConstraints() {
        view.addSubview(segmentedController)
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            segmentedController.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            segmentedController.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            segmentedController.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ])
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: segmentedController.bottomAnchor, constant: 30),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
    
    private func setupNavController() {
        navigationItem.searchController = searchController
        let backImage = UIImage(systemName: "chevron.backward")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(popnav))
        title = "Продукты"
    }
    // Пздц день тяжелый был, сегодня не прогал
    @objc private func popnav() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func fetchProducts() {
        net.fetchProductsList { [self] result in
            switch result {
            case .success(let products):
                self.products = products
            case . failure(let error):
                print(error)
            }
        }
    }
}

extension DetailProductCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO - do not hardcoding
        print(products.count)
        return sortedProducts.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DetailProductCollectionViewCell.id,
            for: indexPath
        ) as! DetailProductCollectionViewCell
        cell.Data = sortedProducts[indexPath.item]
        print(indexPath.item)
        
        return cell
    }
}
extension DetailProductCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (((view.frame.size.width/2.1))*0.9222) , height: (view.frame.size.width/2.1))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
    }
}
//func setNavigationBar() {
//
//    self.navigationItem.setHidesBackButton(true, animated:false)
//
//    //your custom view for back image with custom size
//    let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//    let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
//
//    if let imgBackArrow = UIImage(named: "icn_back_arrow") {
//        imageView.image = imgBackArrow
//    }
//    view.addSubview(imageView)



//Вот это можно использовать наверное для кнопок
//    let backTap = UITapGestureRecognizer(target: self, action: #selector(backToMain))
//    view?.addGestureRecognizer(backTap)
//
//    let leftBarButtonItem = UIBarButtonItem(customView: view ?? UIView())
//    self.navigationItem.leftBarButtonItem = leftBarButtonItem
//}
//
//@objc func backToMain() {
//    self.navigationController?.popViewController(animated: true)
//}
