//
//  Color.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 21/06/25.
//

import Foundation
import SwiftUI

extension Color {
   static let themeColors = ColorTheme()
}

//First things to set up while crerating new project
struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let red = Color("PricedDown")
    let green = Color("PricedUp")
    let gray = Color("SecondaryTextColor")
    
}
