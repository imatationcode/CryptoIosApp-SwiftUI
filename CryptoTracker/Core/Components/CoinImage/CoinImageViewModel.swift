//
//  CoinImageViewModal.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 02/07/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var coinImage: UIImage? = nil
    
    private let coin: CoinModal
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init( coin: CoinModal) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscriber()
        self.isLoading = true
        
    }
    
    private func addSubscriber() {
        dataService.$coinImage
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.coinImage = returnedImage
            }
            .store(in: &cancellables)
        
    }
}
