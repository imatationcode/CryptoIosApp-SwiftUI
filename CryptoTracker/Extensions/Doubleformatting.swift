//
//  Doubleformatting.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 24/06/25.
//

import Foundation

extension Double {
    /// Converts a double to Currency with 2 to 6 decimal
    /// ```
    ///Convert 123.534 to $1,234.53
    /// ```
    private static var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }()
    
    func asCurrencywithTwoToSixDecimal() -> String {
        return Double.currencyFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    func asNumberToStringWithTwoDecimal() -> String {
        return String(format: "%.2f", self)
    }
    
    func asNumberWithPercentageSign() -> String {
        return asNumberToStringWithTwoDecimal() + "%"
    }
}
