//
//  Double+.swift
//  ChefDelivery
//
//  Created by Eduardo Moretto on 06/07/24.
//

import Foundation

extension Double {
    func formatPrice() -> String {
        let formattedString = String(format: "%.2f", self)
        return formattedString.replacingOccurrences(of: ".", with: ",")
    }
}
