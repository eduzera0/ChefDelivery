//
//  ProductType.swift
//  ChefDelivery
//
//  Created by Eduardo Moretto on 06/07/24.
//

import Foundation

struct ProductType: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let image: String
    let price: Double
    
    var formattedPrice: String {
        return "R$" + price.formatPrice()
    }
}
