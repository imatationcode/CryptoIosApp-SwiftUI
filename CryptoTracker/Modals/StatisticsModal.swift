//
//  StatisticsModal.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 04/07/25.
//

import Foundation

struct StatisticsModal: Identifiable {
    let id: String = UUID().uuidString //random ID
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChnage: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChnage
    }
}
