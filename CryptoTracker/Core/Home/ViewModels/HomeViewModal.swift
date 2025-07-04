//
//  HomeViewModal.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 28/06/25.
//

import Foundation
import Combine

class HomeViewModal: ObservableObject {
    @Published var allCoinList: [CoinModal] = []
    
    @Published var holdingsCoinList: [CoinModal] = []
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService() // that get all coins in init function will be exuted
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    func addSubscriber() {
        
//        coinDataService.$allCoins
//            .sink { [weak self] (returnedCoins) in
//                self?.allCoinList = returnedCoins
//            }
//            .store(in: &cancellables)
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .map { (text, startingCoins) -> [CoinModal] in
                guard !text.isEmpty else {
                    return startingCoins
                }
                
                let searchTextLowercased = text.lowercased()
                
                return startingCoins.filter { (coin) -> Bool in
                    return coin.name.lowercased().contains(searchTextLowercased) ||
                    coin.id.lowercased().contains(searchTextLowercased) ||
                    coin.symbol.lowercased().contains(searchTextLowercased)
                }
                
            }
        
            .sink { [weak self] (returnedCoins) in
                self?.allCoinList = returnedCoins
            }
            .store(in: &cancellables)
    }
}
