//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 24/06/25.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModal
    let showHoldings: Bool
    
    var body: some View {
        HStack {
            leftView
            Spacer()
            if showHoldings {
                middleView
            }
            
            rightView
        }
        .font(.subheadline)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    
    CoinRowView(coin: DeveloperMockData.instance.coin, showHoldings: true)
//            .environment(\.colorScheme, .dark)
}

extension CoinRowView {
    
    private var leftView: some View {
        HStack {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.themeColors.gray)
                .frame(minWidth: 30)
            Circle()
                .frame(width: 30, height: 30)
            Text("\(coin.symbol.uppercased())")
                .font(.headline)
                .foregroundColor(Color.themeColors.accent)
        }
    }
    
    private var middleView: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingValue.asNumberToStringWithTwoDecimal())
                .foregroundColor(Color.themeColors.accent)
            Text(coin.currentHoldings?.asNumberToStringWithTwoDecimal() ?? "0")
                .foregroundColor(Color.themeColors.accent)
        }
        
    }
    
    private var rightView: some View {
        VStack(alignment: .trailing) {
            Text("\(coin.currentPrice.asCurrencywithTwoToSixDecimal())")
                .foregroundColor(Color.themeColors.accent)
                .font(.headline)
            Text(coin.priceChangePercentage24H?.asNumberWithPercentageSign() ?? " ")
                .font(.caption)
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0 ) >= 0 ? Color.themeColors.green : Color.themeColors.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
