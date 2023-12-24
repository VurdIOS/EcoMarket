//
//  DetailProductCollectionView.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 12.12.2023.
//

import UIKit



class DetailProductCollectionView: UIViewController {
    private let productsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(
            DetailProductCollectionViewCell.self,
            forCellWithReuseIdentifier: DetailProductCollectionViewCell.id
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private let categoriesCollectionViewFlowLayout: UICollectionViewFlowLayout = {
       let flow = UICollectionViewFlowLayout()
//        flow.itemSize = CGSize(width: 100, height: 50)
        flow.scrollDirection = .horizontal

//        flow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return flow
    }()
    let items = ["Все", "Фрукты", "Сухофрукты", "Овощи", "Зелень", "Чай кофе", "Молочные продукты"]
    
    private lazy var categoriesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: categoriesCollectionViewFlowLayout)
        collectionView.register(
            SegmentControlCollectionViewCell.self,
            forCellWithReuseIdentifier: SegmentControlCollectionViewCell.id
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return collectionView
    }()
    
    let segment = UISegmentedControl()

    var startTypeProduct: Int!
    var productsCategories: [ProductCategory] = []
    var products: [Product] = [] {
        didSet {
            checkSegmentedControllerState()
        }
    }
    var sortedProducts: [Product] = [] {
        didSet {
            productsCollectionView.reloadData()
        }
    }
    
    var orderedProducts: [Product] = [] {
        didSet {
            let cost = sumOrderedPrices(products: orderedProducts)
            cartWidget.setTitle("Корзина \(cost) с", for: .normal)
            SharedData.shared.dataToPass = orderedProducts
            print(orderedProducts)
            }
            
    }
    
    let cartWidget: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "TabBarCart"), for: .normal)
        btn.setTitle(" Корзина", for: .normal)
        btn.backgroundColor = .AccentColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 24
        btn.titleLabel?.font = UIFont(name: "TTNormsPro-Bold", size: 16)
        
        return btn
    }()
    
 

    
    

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
        setupTargetActions()
        
        productsCollectionView.delegate = self
        categoriesCollectionView.delegate = self
        productsCollectionView.dataSource = self
        categoriesCollectionView.dataSource = self
//        self.tabBarController?.delegate = self
    }
    private func setupTargetActions() {
        cartWidget.addTarget(self, action: #selector(cartWidgetTapped), for: .touchUpInside)
    }
    @objc private func cartWidgetTapped() {
        let vc = CartView()
        
//        vc.
        present(vc, animated: true)

    }

    // TODO -  СДелать красивее› Еще баг с добавлением продуктов, добавляеются из соседних страниц
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
    private func sumOrderedPrices(products: [Product]) -> Int {
        let cost = products.reduce(0) { partialResult, product in
            var partResult = partialResult
            let products = (product.price.components(separatedBy: ".")[0])
            let cost = Int(products)!
            partResult += cost * product.quantity
            return partResult
        }
        return cost
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
        searchController.showsSearchResultsController = true
        searchController.automaticallyShowsCancelButton = false
        searchController.searchBar.placeholder = "Быстрый поиск"
        searchController.searchBar.searchTextField.backgroundColor = .clear
//        searchController.searchBar.setImage(UIImage(named: "TabBarHome"), for: .search, state: .normal)
    }
    
    private func setupConstraints() {
        
//        view.addSubview(segmentedController)
        view.addSubview(productsCollectionView)
        view.addSubview(categoriesCollectionView)
        view.addSubview(cartWidget)


        NSLayoutConstraint.activate([
            categoriesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0 ),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 30) // Пример высоты
        ])
        
        
        NSLayoutConstraint.activate([
            productsCollectionView.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor, constant: 13),
            productsCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productsCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            productsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
      
        
        NSLayoutConstraint.activate([
            cartWidget.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            cartWidget.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            cartWidget.widthAnchor.constraint(greaterThanOrEqualToConstant: 168),
            cartWidget.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    private func setupNavController() {
        navigationItem.searchController = searchController
        let backImage = UIImage(systemName: "chevron.backward")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(popnav))
        title = "Продукты"
    }
    
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
        if collectionView == productsCollectionView {
            return sortedProducts.count
        } else {
            return items.count
        }
        

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productsCollectionView {
            let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: DetailProductCollectionViewCell.id,
                    for: indexPath
                ) as! DetailProductCollectionViewCell
                cell.Data = sortedProducts[indexPath.item]
                cell.delegate = self
                return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: SegmentControlCollectionViewCell.id,
                    for: indexPath
                ) as! SegmentControlCollectionViewCell
            cell.data = items[indexPath.item]
            cell.layer.cornerRadius = cell.frame.height/2
            cell.clipsToBounds = true
                
                return cell
        }
        
       
    }
}

extension DetailProductCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailProductInfoView()
        vc.product = sortedProducts[indexPath.item]
        present(vc, animated: true)
    }
}
    
extension DetailProductCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == productsCollectionView {
            let width = (view.frame.width - 43)/2
            return CGSize(width: width , height: 228)
        } else {
            let item = items[indexPath.item]
            return CGSize(width: item.widthOfString(usingFont: UIFont(name: "TTNormsPro-Bold", size: 16)!) + 24, height: 27)
        }
            
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == productsCollectionView {
            return UIEdgeInsets(top: 11, left: 16, bottom: 0, right: 16)
        } else {
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        }
        
    }
}

extension DetailProductCollectionView: DetailProductCollectionViewCellDelegate {
    func append(products: Product) {
        if let index = orderedProducts.firstIndex(where: { $0.id == products.id }) {
            orderedProducts[index].quantity += 1
            CoreDataManager.shared.updateProducts(with: products.id, newQuantity: orderedProducts[index].quantity + 1)
        } else {
            orderedProducts.append(products)
            CoreDataManager.shared.createOrderProduct(product: products)
        }
    }
    func minus(products: Product) {
        if let index = orderedProducts.firstIndex(where: { $0.id == products.id }) {
            orderedProducts[index].quantity -= 1
            CoreDataManager.shared.updateProducts(with: products.id, newQuantity: orderedProducts[index].quantity - 1)
            if orderedProducts[index].quantity == 0 {
                orderedProducts.remove(at: index)
                CoreDataManager.shared.deleteProduct(with: orderedProducts[index].id)
            }
        }
    }
}

//extension DetailProductCollectionView: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        let viewController  = tabBarController.viewControllers?[1] as! CartView
//        viewController.productsInCart = orderedProducts
//        return true
//    }
//}
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
