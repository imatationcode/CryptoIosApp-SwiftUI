//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 21/06/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        //background layer
        ZStack {
            Color.themeColors.background
                .ignoresSafeArea()
            
            //content layer
            VStack {
                HStack {
                    CircularButtonView(iconName: "info")
                    Spacer()
                    Text("Live Prices")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.themeColors.accent)
                    Spacer()
                    CircularButtonView(iconName: "chevron.right")
                }
                .padding(.horizontal)
                Spacer()

            }
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
}
