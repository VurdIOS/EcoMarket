//
//  HistoryView.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 11.12.2023.
//

import UIKit

class HistoryView: UIViewController {
    
    var order: [Order] = [] {
        didSet {
            print(order)
        }
    }
    
    let exampleorder = OrderPost(products: [OrderItem(product: 2, quantity: 3)], phoneNumber: "213123", addres: "12312312", referencePoint: "12312312", comments: "123123")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .MainBackgroundColor
        postnet(model: exampleorder)
//        net()


        // Do any additional setup after loading the view.
    }
    
    private func net() {
        NetworkManager.shared.fetchOrderList { result in
            switch result {
            case.success(let order):
                self.order = order
            case .failure(let error):
                print("Упали во время запроса истории заказов")
                print(error.localizedDescription)
            }
        }
    }
    
    private func postnet(model: OrderPost) {
        NetworkManager.shared.POSTOrderList(with: model) { result in
            switch result {
            case .success(let oreder):
                print("zaebis")
                let orr = oreder
                print(orr)
            case .failure(let error):
                print("Упали во время отправки данных")
                print(error.localizedDescription)
            }
        }
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
