//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 21/06/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm : HomeViewModal
    @State var showSettingsView: Bool = false
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
            .sheet(isPresented: $showSettingsView, content: {
                SettingsView()
                    .environmentObject(vm)
            })
            Spacer(minLength: 0.0)
            
            // Floating reload button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        withAnimation(.linear(duration: 2.0)) {
                            vm.reloadAllCoinData()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .resizable()
                            .foregroundColor(Color.themeColors.accent)
                            .frame(width: 40, height: 40)
                            .background(
                                Circle()
                                    .fill(Color.themeColors.background)
                            )
                            .shadow(
                                color: Color.themeColors.accent.opacity(0.3), radius: 10.0)
//                            .padding()
//                            .frame(width: 50, height: 50)
//                            .foregroundColor(Color.themeColors.accent)
//                            .shadow(color: Color.themeColors.accent.opacity(0.3), radius: 10, x: 5, y: 5)
                    }
                    .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0))
                    .padding()
                }
            }
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
//                    if view is showing user portfolio
                    if showPortfolio {
                        showProtolioSheetView.toggle()
                    } else {
                        showSettingsView.toggle()
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
