//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 08/07/25.
//

import SwiftUI

struct PortfolioSheetView: View {
    
    @EnvironmentObject private var vm: HomeViewModal
    @Environment(\.dismiss) private var dismiss
    
    var body: some View { // Keep NavigationView if you need its title and toolbar
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    ScrollView(.horizontal, showsIndicators: true) {
                        LazyHStack(spacing: 10) { //lazyHstack since there will be lots of iteams and we just want to load only the elements which are on screen
                            
                            ForEach(vm.allCoinList) { coin in
                                CoinCardView(coin: coin)
                            }
                        }
                        
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkDissmisButton(action: { dismiss() })
                }
            }
        }
    }
}

#Preview {
    PortfolioSheetView()
        .environmentObject(DeveloperMockData.instance.homeVM)
}
