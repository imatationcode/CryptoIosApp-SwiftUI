//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 11/06/25.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @StateObject private var  vm = HomeViewModal()
    @State var showLaunchScreen: Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.themeColors.accent)]
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.themeColors.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .environmentObject(vm)
                
                ZStack {
                    if showLaunchScreen {
                        LauchView(showLaunchScreen: $showLaunchScreen)
                            .transition(.move(edge: .trailing))
                    }
                }
                .zIndex(2.0 )
            }
        }
    }
}
