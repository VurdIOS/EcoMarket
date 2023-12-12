//
//  AF.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 12.12.2023.
//

import Foundation
import Alamofire
enum ApiURL: String {
    case OrderList = "https://neobook.online/ecobak/order-list"
    case ProductCategoryList = "https://neobook.online/ecobak/product-category-list"
    case ProductList = "https://neobook.online/ecobak/product-list"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    
    
    func fetchProductsList(completion: @escaping(Result<[Product], AFError>) -> Void) {
        let request = AF.request(ApiURL.ProductList.rawValue)
        request.responseDecodable(of: [Product].self) { (response) in
            switch response.result {
            case .success(let value):
                let productList = value
                completion(.success(productList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
//    func fetchProductsCategories() -> [ProductCategory] {
//        let request = AF.request(ApiURL.ProductCategoryList.rawValue)
//        var products = [ProductCategory]()
//        request.responseDecodable(of: [ProductCategory].self) { (response) in
//            guard let productList = response.value else { return }
//            products = productList
//        }
//        
//    }
    
    func fetchOrderList() -> [Order] {
        let request = AF.request(ApiURL.OrderList.rawValue)
        var orders = [Order]()
        request.responseDecodable(of: [Order].self) { (response) in
            guard let orderList = response.value else { return }
            orders = orderList
        }
        return orders
    }
}


