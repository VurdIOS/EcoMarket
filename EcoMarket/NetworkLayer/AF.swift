//
//  AF.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 12.12.2023.
//

import UIKit
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
    
    func fetchProductsCategories(completion: @escaping(Result<[ProductCategory], AFError>) -> Void) {
        let request = AF.request(ApiURL.ProductCategoryList.rawValue)
        request.responseDecodable(of: [ProductCategory].self) { (response) in
            switch response.result {
            case .success(let value):
                let productCategoryList = value
                completion(.success(productCategoryList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchOrderList(completion: @escaping(Result<[Order], AFError>) -> Void) {
        let request = AF.request(ApiURL.OrderList.rawValue)
        request.responseDecodable(of: [Order].self) { (response) in
            switch response.result {
            case .success(let value):
                let orederList = value
                completion(.success(orederList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


