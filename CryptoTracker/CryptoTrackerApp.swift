//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 11/06/25.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
