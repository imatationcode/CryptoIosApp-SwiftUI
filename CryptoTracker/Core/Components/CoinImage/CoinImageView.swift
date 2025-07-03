//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 30/06/25.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject var vm: CoinImageViewModel
    
    init(coin: CoinModal){
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            Color.themeColors.background
            // if we get an image
            if let image = vm.coinImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading { //if the image is loading
                ProgressView()
            } else { //if some error occurs
                Image(systemName: "questionmark.circle")
            }
        }
    }
}

#Preview {
    CoinImageView(coin: DeveloperMockData.instance.coin)
}
