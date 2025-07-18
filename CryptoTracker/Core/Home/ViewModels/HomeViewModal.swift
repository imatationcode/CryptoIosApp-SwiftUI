//
//  HomeViewModal.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 28/06/25.
//

import Foundation
import Combine

class HomeViewModal: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var statistics: [StatisticsModal] = []
    
    @Published var allCoinList: [CoinModal] = []

    @Published var holdingsCoinList: [CoinModal] = []
    
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService() // that get all coins when init function will be exuted
    
    private let marketDataService = GlobelMarketDataService()
    
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    func updatePortfolio(coin: CoinModal, amount: Double) {
        portfolioDataService.updatePortfolioData(coin: coin, amount: amount)
    }
    
    func reloadAllCoinData() {
        isLoading = true
        coinDataService.getAllCoins()
        marketDataService.getData()
        HapticManager.impact()
    }
    
    func addSubscriber() {
        
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
        
        // updates portfolio
        $allCoinList
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coinModels, portfolioEntities) -> [CoinModal] in
                coinModels
                    .compactMap { (coin) -> CoinModal? in
                        guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [weak self] (returnedCoins) in
                self?.holdingsCoinList = returnedCoins
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .combineLatest($holdingsCoinList)
            .map { (marketDataModal: MarketDataModal?, holdingsCoinList: [CoinModal]) -> [StatisticsModal] in
                var stats: [StatisticsModal] = []
                
                guard let data = marketDataModal else { return stats }
                
                let marketCap = StatisticsModal(title: "Market Cap", value: data.marketCap, percentageChnage: data.marketCapChangePercentage24HUsd)
                let volume = StatisticsModal(title: "24h Volume", value: data.volume)
                let btcDominance = StatisticsModal(title: "BTC Dominance", value: data.btcDominance)
                
                let currentPortfolioValue = holdingsCoinList
                    .map { (coin) -> Double in
                        return coin.currentHoldingValue
                    }
                    .reduce(0, +)
                // To get the percentage change we need previous value
                let previousPortfolioValue =
                holdingsCoinList
                    .map { (coin) -> Double in
                        let currentValue = coin.currentHoldingValue
                        let percentageChange = (coin.priceChangePercentage24H ?? 0) / 100
                        let previousValue = currentValue / (1 + percentageChange)
                        return previousValue
                        
                    }
                    .reduce(0, +)
                
                let portfolioChangePercentage = ((currentPortfolioValue - previousPortfolioValue) / previousPortfolioValue) * 100
                
                let portfolioSection = StatisticsModal(title: "Portfolio Value", value: currentPortfolioValue.asCurrencywithTwoToSixDecimal(), percentageChnage: portfolioChangePercentage)
                
                stats.append(contentsOf: [
                    marketCap,
                    volume,
                    btcDominance,
                    portfolioSection
                ])
                
                return stats
            }
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
    }
}
