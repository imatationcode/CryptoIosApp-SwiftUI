//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 11/06/25.
//

import SwiftUI
// Theme colors testing 
struct ContentView: View {
        var body: some View {
            ZStack {
                Color.themeColors.background
                VStack {
                    Text("Hello, World! Accent Color")
                        .foregroundColor(Color.themeColors.accent)
                    Text("Secondary Color")
                        .foregroundColor(Color.themeColors.gray)
                    Text("Price Down Color")
                        .foregroundColor(Color.themeColors.red)
                    Text("Price UP Color")
                        .foregroundColor(Color.themeColors.green)
                }
            }
    }
}

#Preview {
    ContentView()
}
