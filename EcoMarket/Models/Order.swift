//
//  Order.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 12.12.2023.
//

import Foundation
struct Order: Codable {
    var orderNumber: Int
    var products: [OrderItem]
    var phoneNumber: String
    var addres: String
    var referencePoint: String
    var comments: String
    var totalAmount: String
    var createdAt: String
    var deliveryCost: Int
    var orderedProducts: String
    
    
    enum CodingKeys: String, CodingKey {
        case orderNumber = "order_number"
        case products
        case phoneNumber = "phone_number"
        case addres
        case referencePoint = "reference_point"
        case comments
        case totalAmount = "total_amount"
        case createdAt = "created_at"
        case deliveryCost = "delivery_cost"
        case orderedProducts = "ordered_products"

    }
}
