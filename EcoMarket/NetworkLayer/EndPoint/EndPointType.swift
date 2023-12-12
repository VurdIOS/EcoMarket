//
//  EndPointType.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 12.12.2023.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders { get }
}
