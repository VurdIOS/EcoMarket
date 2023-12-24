//
//  OrderPost.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 24.12.2023.
//

import Foundation
struct OrderPost: Codable {
    var products: [OrderItem]
    var phoneNumber: String
    var addres: String
    var referencePoint: String
    var comments: String
    
    
    enum CodingKeys: String, CodingKey {
        case products
        case phoneNumber = "phone_number"
        case addres
        case referencePoint = "reference_point"
        case comments
    }
}
