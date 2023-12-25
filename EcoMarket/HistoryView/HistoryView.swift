//
//  HistoryView.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 11.12.2023.
//

import UIKit

class HistoryView: UIViewController {
    
    private let ordersCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(
            HistoryViewCollectionViewCell.self,
            forCellWithReuseIdentifier: HistoryViewCollectionViewCell.id
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var orders: [Order] = [] {
        didSet {
            ordersCollectionView.reloadData()
        }
    }
    // just for fun
    
    let exampleorder = OrderPost(products: [OrderItem(product: 2, quantity: 200)], phoneNumber: "213123", address: "kjmknmiknm", referencePoint: "12312312", comments: "123123")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .MainBackgroundColor
        title = "История заказов"
        net()
        setupConstraints()
        ordersCollectionView.delegate = self
        ordersCollectionView.dataSource = self

        


        // Do any additional setup after loading the view.
    }
    
    private func setupConstraints() {
        view.addSubview(ordersCollectionView)
        
        
        NSLayoutConstraint.activate([
            ordersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            ordersCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            ordersCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            ordersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func net() {
        NetworkManager.shared.fetchOrderList { [unowned self] result in
            switch result {
            case.success(let order):
                self.orders = order
            case .failure(let error):
                print("Упали во время запроса истории заказов")
                print(error.localizedDescription)
            }
        }
    }
    
//    private func postnet(model: OrderPost) {
//        NetworkManager.shared.POSTOrderList(with: model) { result in
//            switch result {
//            case .success(let oreder):
//                print("zaebis")
//                let orr = oreder
//                print(orr)
//            case .failure(let error):
//                print("Упали во время отправки данных")
//                print(error.localizedDescription)
//            }
//        }
//    }

}

extension HistoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(orders.count)
        return orders.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HistoryViewCollectionViewCell.id,
            for: indexPath
        ) as! HistoryViewCollectionViewCell
        cell.contentView.layer.cornerRadius = 15

        cell.setup(with: orders[indexPath.item])
        
        
        return cell
    }
}
    
extension HistoryView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (view.frame.width - 32)
            return CGSize(width: width , height: 70)
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//            return UIEdgeInsets(top: 11, left: 16, bottom: 0, right: 16)
//    }
}
