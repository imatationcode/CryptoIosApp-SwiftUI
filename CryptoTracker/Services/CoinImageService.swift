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
    private let coin: CoinModal
    private let localfileManager  = LocalFileManager.instance
    private let foldername: String = "Coin_Images"
    private let imageName: String
    
    var imageSubscription: AnyCancellable?
    
    init (coin: CoinModal) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = localfileManager.getImage(imageName: imageName, folderName: foldername) {
            coinImage = savedImage
            print("Image retrived from folder locally")
        } else {
            downloadCoinImage()
            print("Image downloaded from internet")
        }
    }
    
    private func downloadCoinImage() {
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
                guard let self = self,
                let downlodedImage = returnedImage else { return }
                self.coinImage = returnedImage
                self.imageSubscription?.cancel()
                self.localfileManager.saveImage(image: downlodedImage, imageName: self.imageName, folderName: self.foldername)
            })
    }
}
