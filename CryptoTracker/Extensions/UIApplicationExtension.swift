//
//  UIApplicationExtension.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 04/07/25.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEdit() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil , for: nil)
    }
}
