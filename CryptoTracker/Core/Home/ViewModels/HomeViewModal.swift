//
//  HomeViewModal.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 28/06/25.
//

import Foundation
import Combine

class HomeViewModal: ObservableObject {
    
    @Published var statistics: [StatisticsModal] = []
    
    @Published var allCoinList: [CoinModal] = []
    
    @Published var holdingsCoinList: [CoinModal] = []
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService() // that get all coins when init function will be exuted
    
    private let marketDataService = GlobelMarketDataService()
    
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
        
        marketDataService.$marketData
            .map { (marketDataModal) -> [StatisticsModal] in
                var stats: [StatisticsModal] = []
                
                guard let data = marketDataModal else { return stats }
                
                let marketCap = StatisticsModal(title: "Market Cap", value: data.marketCap, percentageChnage: data.marketCapChangePercentage24HUsd)
                let volume = StatisticsModal(title: "24h Volume", value: data.volume)
                let btcDominance = StatisticsModal(title: "BTC Dominance", value: data.btcDominance)
                let portFolioValue = StatisticsModal(title: "Portfolio Value", value: "50.00", percentageChnage: 0)
                
                stats.append(contentsOf: [
                    marketCap,
                    volume,
                    btcDominance,
                    portFolioValue
                ])
                
                return stats
            }
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
    }
}
