//
//  GlobelMarketDataService.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 07/07/25.
//

import Foundation
import Foundation
import Combine

class GlobelMarketDataService {
    
    @Published var marketData: MarketDataModal? = nil
    
    var marketDataSubcription: AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData() {
        // 1. Create a URL object from the string.
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global")
        else {
            print("Invalid URL")
            return
        }
        
        marketDataSubcription = NetworkingManager.fetchData(from: url)
            .decode(type: GlobalMarketDataModal.self, decoder: JSONDecoder())
            .sink (receiveCompletion:
                    NetworkingManager.handdleCompletion
                   , receiveValue: { [weak self] returnedGlobalMarketData in
                self?.marketData = returnedGlobalMarketData.data
                self?.marketDataSubcription?.cancel()
            })
    }
}



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

//
//    }
//}
