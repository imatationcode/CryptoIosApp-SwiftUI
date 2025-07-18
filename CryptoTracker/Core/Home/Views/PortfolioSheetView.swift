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
    
    @State private var selectedCoin: CoinModal? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmarkSaveButton: Bool = false
    
    var body: some View { // Keep NavigationView if you need its title and toolbar
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    horizontalCoinListView
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkDissmisButton(action: { dismiss() })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 5) {
                        Image(systemName: "checkmark")
                            .opacity(showCheckmarkSaveButton ? 1.0 : 0.0)
                        Button {
                            saveButtonPressed()
                        } label: {
                            Text("Save".uppercased())
                        }
                        .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)

                            
                    }
                    .font(.headline)
                }
            }
            .onChange(of: vm.searchText) {
                if vm.searchText.isEmpty {
                    removeSelectedCoin()
                }
            }

        }
    }
}

#Preview {
    PortfolioSheetView()
        .environmentObject(DeveloperMockData.instance.homeVM)
}

extension PortfolioSheetView {
    
    private var horizontalCoinListView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) { //lazyHstack since there will be lots of iteams and we just want to load only the elements which are on screen
                
                ForEach(vm.searchText.isEmpty ? vm.holdingsCoinList : vm.allCoinList) { coin in
                    CoinCardView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                                UIApplication.shared.endEdit()
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke( selectedCoin?.id == coin.id ? Color.themeColors.green : Color.clear, lineWidth: 1)
                        )
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current Price of:  \(selectedCoin?.symbol.uppercased() ?? "" ):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencywithTwoToSixDecimal() ?? "")
            }
            Divider()
            HStack {
                Text("Enter Amount in Your portfolio")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current Value:")
                Spacer()
                Text(getCurrentValue().asCurrencywithTwoToSixDecimal())
            }
        }
        .padding()

    }
    
    private func getCurrentValue() -> Double {
        if let quantity =  Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
        
        //save coin to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        // show the checkmark
        withAnimation(.easeIn) {
            showCheckmarkSaveButton = true
            removeSelectedCoin()
        }
        
        UIApplication.shared.endEdit()
        
        //hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut) {
                showCheckmarkSaveButton = false
            }
        }
        
    }
    
    private func removeSelectedCoin() {
        self.selectedCoin = nil
        self.vm.searchText = ""
        self.quantityText = ""
    }
}
