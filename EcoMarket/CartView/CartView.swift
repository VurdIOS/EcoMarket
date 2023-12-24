//
//  CartView.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 11.12.2023.
//

import UIKit

class CartView: UIViewController {
    
    var productsInCart: [Product]? = [] {
        didSet {
            let costOfProducts = sumOrderedPrices(products: productsInCart ?? [])
            summCostLabel.text = String(costOfProducts)
            deliveryCostLabel.text = "150"
            sumSumCostLabel.text = String(costOfProducts + 150)
        }
    }
    
    private var data = CoreDataManager.shared.fetchProducts()
    
    private let productsInCartCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(
            CartViewCollectionViewCell.self,
            forCellWithReuseIdentifier: CartViewCollectionViewCell.id
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    private let summTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Сумма"
        lbl.textColor = .greyForBorders
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "TTNormsPro-Medium", size: 16)
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    private let summCostLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "0 c"
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "TTNormsPro-Medium", size: 16)
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    private let deliveryTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Доставка"
        lbl.textColor = .greyForBorders
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "TTNormsPro-Medium", size: 16)
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    private let deliveryCostLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "0 c"
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "TTNormsPro-Medium", size: 16)
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    private let sumSumTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Итого"
        lbl.textColor = .greyForBorders
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "TTNormsPro-Medium", size: 16)
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    private let sumSumCostLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "0 c"
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "TTNormsPro-Medium", size: 16)
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    let confirmButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Оформить заказ", for: .normal)
        btn.backgroundColor = .AccentColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 12
        return btn
        
    }()
    
    private let VStackAmountcostsBlock: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = 16.0
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        
        return stack
    }()
    private let VStackAmountNamesBlock: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = 16.0
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        
        return stack
    }()
    
    private let HStackMoneyBlock: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = 16.0
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        
        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargetsForButtons()
        
        productsInCart = convertToProduct(from: CoreDataManager.shared.fetchProducts())
        
        VStackAmountNamesBlock.addArrangedSubview(summTitleLabel)
        VStackAmountNamesBlock.addArrangedSubview(deliveryTitleLabel)
        VStackAmountNamesBlock.addArrangedSubview(sumSumTitleLabel)
        VStackAmountcostsBlock.addArrangedSubview(summCostLabel)
        VStackAmountcostsBlock.addArrangedSubview(deliveryCostLabel)
        VStackAmountcostsBlock.addArrangedSubview(sumSumCostLabel)
        HStackMoneyBlock.addArrangedSubview(VStackAmountNamesBlock)
        HStackMoneyBlock.addArrangedSubview(VStackAmountcostsBlock)
        
        view.addSubview(productsInCartCollectionView)
        view.addSubview(confirmButton)
        view.addSubview(HStackMoneyBlock)
        view.backgroundColor = .white
        
        
        setupNavController()
        productsInCartCollectionView.delegate = self
        productsInCartCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            productsInCartCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            productsInCartCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productsInCartCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            productsInCartCollectionView.bottomAnchor.constraint(equalTo: HStackMoneyBlock.topAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            confirmButton.heightAnchor.constraint(equalToConstant: 54)
        ])
        
        NSLayoutConstraint.activate([
            HStackMoneyBlock.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            HStackMoneyBlock.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -20),
            HStackMoneyBlock.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32)
        ])
        
    }
    override func viewWillAppear(_ animated: Bool) {
        productsInCart = convertToProduct(from: CoreDataManager.shared.fetchProducts())
        productsInCartCollectionView.reloadData()
    }
    // Категорически переделать
    override func updateViewConstraints() {
 
        view.frame.size.height = 600
        view.frame.origin.y = UIScreen.main.bounds.height - 400 - 282
        super.updateViewConstraints()
    }
    private func convertToProduct(from: [CDProduct]) -> [Product] {
        var products: [Product] = []
        for product in from {
            products.append(Product(id: Int(product.id), title: product.title!, description: product.description, category: Int(product.category), image: product.image!, quantity: Int(product.quantity), price: product.price!))
        }
        return products
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
    
    
    private func setupNavController() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Очистить", style: .done, target: self, action: #selector(cleanButtonTapped))
        title = "Корзина"
    }
    
    @objc private func cleanButtonTapped() {
        CoreDataManager.shared.deleteAllProducts()
        data = CoreDataManager.shared.fetchProducts()
        productsInCart = convertToProduct(from: data)

        productsInCartCollectionView.reloadData()
    }
    private func setupTargetsForButtons() {
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    @objc private func confirmButtonTapped() {
        if Int(summCostLabel.text!)! < 300 {
            showAlert()
        } else {
            let vc = ConfirmOrderViewController()
            vc.orderedProducts = productsInCart!
            vc.totalCostLabel.text = "Сумма заказа \(sumSumCostLabel.text!) с"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func showAlert() {
        let alertVC = NotEnoughtAlertViewController()
        
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
}

extension CartView: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsInCart?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CartViewCollectionViewCell.id,
            for: indexPath
        ) as! CartViewCollectionViewCell
        cell.Data = productsInCart?[indexPath.item]
        cell.delegate = self
        
        
        return cell
    }
}
    
extension CartView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (view.frame.width - 32)
            return CGSize(width: width , height: 94)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 11, left: 16, bottom: 0, right: 16)
    }
}

extension CartView : CartViewCollectionViewCellDelegate {
    func append(products: Product) {
        if let index = productsInCart!.firstIndex(where: { $0.id == products.id }) {
            
            CoreDataManager.shared.updateProducts(with: products.id, newQuantity: productsInCart![index].quantity + 1)
            productsInCart = convertToProduct(from: CoreDataManager.shared.fetchProducts())
            print("delegate is done")
        }
    }
    func minus(products: Product) {
        if let index = productsInCart!.firstIndex(where: { $0.id == products.id }) {
            CoreDataManager.shared.updateProducts(with: products.id, newQuantity: productsInCart![index].quantity - 1)
            productsInCart = convertToProduct(from: CoreDataManager.shared.fetchProducts())
            if productsInCart![index].quantity == 0 {
                CoreDataManager.shared.deleteProduct(with: productsInCart![index].id)
                productsInCart!.remove(at: index)
                productsInCart = convertToProduct(from: CoreDataManager.shared.fetchProducts())
                productsInCartCollectionView.reloadData()
                
            }
        }
    }
    
    
}


