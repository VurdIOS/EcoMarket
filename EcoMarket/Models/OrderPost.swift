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
//    var phone_number: String
    var address: String
    var referencePoint: String
//    var reference_point: String
    var comments: String
    
    
    enum CodingKeys: String, CodingKey {
        case products
        case phoneNumber = "phone_number"
        case address
        case referencePoint = "reference_point"
        case comments
    }
}
