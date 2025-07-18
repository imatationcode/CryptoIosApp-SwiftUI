//
//  HapticManager.swift
//  CryptoTracker
//
//  Created by shivakumar Harijan on 18/07/25.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UIImpactFeedbackGenerator(style: .light)
    
    static func impact() {
        generator.prepare()
        generator.impactOccurred()
    }
}
