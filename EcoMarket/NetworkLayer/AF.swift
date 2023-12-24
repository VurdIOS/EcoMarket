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
    case OrderListPOST = "https://neobook.online/ecobak/order-create"
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
    
    func POSTOrderList(with: OrderPost, completion: @escaping(Result<OrderPost, AFError>) -> Void) {
        AF.request(ApiURL.OrderListPOST.rawValue, method: .post, parameters: with, encoder: JSONParameterEncoder.default)
            .responseDecodable(of: OrderPost.self) { response in
//                if let data = response.data {
//                    let responseString = String(data: data, encoding: .utf8)
//                    print("Ответ сервера: \(responseString ?? "Нет данных")")
//                }
                switch response.result {
                case .success(let decodedModel):
                    let oreder = decodedModel
                    completion(.success(oreder))
                    print("Декодированная модель: \(decodedModel)")
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        print("Статус код: \(statusCode)")
                    }
                        completion(.failure(error))
                        print("Ошибка: \(error)")
                    }
            }
    }
}


