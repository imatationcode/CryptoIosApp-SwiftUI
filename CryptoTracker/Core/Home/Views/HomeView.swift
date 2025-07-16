//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 21/06/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm : HomeViewModal
    
    @State var showPortfolio: Bool = false
    @State var showProtolioSheetView: Bool = false //pops up new sheet with Coins
    
    var body: some View {
        //background layer
        ZStack {
            Color.themeColors.background
                .ignoresSafeArea()
                .sheet(isPresented: $showProtolioSheetView) {
                    PortfolioSheetView()
                        .environmentObject(vm)
                }
            //content layer
            VStack {
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                Spacer()
                listColumnTitlesView
                
                if !showPortfolio {
                    allCoinsList
                } else{
                    holdingsCoinList
                }
            }
            Spacer(minLength: 0.0)
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
    .environmentObject(DeveloperMockData.instance.homeVM)
}

extension HomeView {
    
    private var homeHeader: some View {
        HStack {
            CircularButtonView(iconName: showPortfolio ? "plus" : "info")
                .transaction { transaction in
                    transaction.animation = nil
                }
                .onTapGesture {
                    if showPortfolio {
                        showProtolioSheetView.toggle()
                    }
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
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoinList) { coin in
                CoinRowView(coin: coin, showHoldings: false)
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
        .transition(.move(edge: .leading))
        
    }
    
    private var holdingsCoinList: some View {
        List {
            ForEach(vm.holdingsCoinList) { coin in
                CoinRowView(coin: coin, showHoldings: true)
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
        .transition(.move(edge: .trailing))
        
    }
    private var listColumnTitlesView: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .padding(.horizontal)
        .font(.caption)
        .foregroundColor(Color.themeColors.gray)
    }
    
}
