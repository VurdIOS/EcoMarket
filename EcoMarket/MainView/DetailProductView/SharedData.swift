//
//  SharedData.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 20.12.2023.
//

import Foundation

class SharedData {
    static let shared = SharedData()
    var dataToPass: [Product]?
    
    private init() {}
}
