//
//  CoinCardView.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 11/07/25.
//

import SwiftUI

struct CoinCardView: View {
    let coin: CoinModal
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.themeColors.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.themeColors.gray)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CoinCardView(coin: DeveloperMockData.instance.coin)
}
