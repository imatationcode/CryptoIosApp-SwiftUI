//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 21/06/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var showPortfolio: Bool = false
    
    var body: some View {
        //background layer
        ZStack {
            Color.themeColors.background
                .ignoresSafeArea()
            //content layer
            VStack {
                homeHeader
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

extension HomeView {
    
    private var homeHeader: some View {
        HStack {
            CircularButtonView(iconName: showPortfolio ? "plus" : "info")
                .transaction { transaction in
                    transaction.animation = nil
                }
                .background(AnimationForCircularButton(isAnimating: $showPortfolio))
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.themeColors.accent)
                .transaction { transaction in
                    transaction.animation = nil
                }
            Spacer()
            CircularButtonView(iconName: "chevron.right")
                .rotationEffect(.degrees(showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        self.showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
}
