//
//  CoinImageService.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 30/06/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    @Published var coinImage: UIImage? = nil
    let coin: CoinModal
    
    var imageSubscription: AnyCancellable?
    
    init (coin: CoinModal) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image)
        else {
            print("Invalid URL")
            return
        }
        
        imageSubscription = NetworkingManager.fetchData(from: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
        
            .sink (receiveCompletion:
                    NetworkingManager.handdleCompletion
                   , receiveValue: { [weak self] returnedImage in
                self?.coinImage = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
}
