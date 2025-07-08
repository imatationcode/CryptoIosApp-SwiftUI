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
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
       /// ```
       /// Convert 12 to 12.00
       /// Convert 1234 to 1.23K
       /// Convert 123456 to 123.45K
       /// Convert 12345678 to 12.34M
       /// Convert 1234567890 to 1.23Bn
       /// Convert 123456789012 to 123.45Bn
       /// Convert 12345678901234 to 12.34Tr
       /// ```
       func formattedWithAbbreviations() -> String {
           let num = abs(Double(self))
           let sign = (self < 0) ? "-" : ""

           switch num {
           case 1_000_000_000_000...:
               let formatted = num / 1_000_000_000_000
               let stringFormatted = formatted.asNumberToStringWithTwoDecimal()
               return "\(sign)\(stringFormatted)Tr"
           case 1_000_000_000...:
               let formatted = num / 1_000_000_000
               let stringFormatted = formatted.asNumberToStringWithTwoDecimal()
               return "\(sign)\(stringFormatted)Bn"
           case 1_000_000...:
               let formatted = num / 1_000_000
               let stringFormatted = formatted.asNumberToStringWithTwoDecimal()
               return "\(sign)\(stringFormatted)M"
           case 1_000...:
               let formatted = num / 1_000
               let stringFormatted = formatted.asNumberToStringWithTwoDecimal()
               return "\(sign)\(stringFormatted)K"
           case 0...:
               return self.asNumberToStringWithTwoDecimal()

           default:
               return "\(sign)\(self)"
           }
       }
}
