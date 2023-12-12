//
//  Product.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 12.12.2023.
//

import Foundation

struct Product: Decodable {
    var id: Int
    var title: String
    var description: String
    var category: Int
    var image: String
    var quantity: Int
    var price: String
}
