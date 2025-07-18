//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 28/06/25.
//
import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [CoinModal] = []
    var coinSubscription: AnyCancellable?
    
    init() {
        getAllCoins()
    }
    
    func getAllCoins() {
        // 1. Create a URL object from the string.
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en&precision=2")
        else {
            print("Invalid URL")
            return
        }
        
        coinSubscription = NetworkingManager.fetchData(from: url)
        
        ///Below code is moved to Netwrok Manager file for Resualble purpose
        //        URLSession.shared.dataTaskPublisher(for: request)
        //            .subscribe(on: DispatchQueue.global())
        //            .tryMap { (output) -> Data in
        //                guard let response = output.response as? HTTPURLResponse,
        //                      response.statusCode >= 200 && response.statusCode < 300 else {
        //                          throw URLError(.badServerResponse)
        //                      }
        //                return output.data
        //            }
        //            .receive(on: DispatchQueue.main)
        
        
            .decode(type: [CoinModal].self, decoder: JSONDecoder())
            .sink (receiveCompletion:
                    NetworkingManager.handdleCompletion
                   , receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}

