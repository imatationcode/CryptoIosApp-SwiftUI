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
    
    private func getAllCoins() {
        // 1. Create a URL object from the string.
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en&precision=2")
        else {
            print("Invalid URL")
            return
        }
        
        // 2. Create a URLRequest to add headers.
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // 3. Access the API key from your Credentials struct.
        let apiKey = APICredentials.coingeckoAPIKey
        
        // 4. Set the headers required by the API.
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue(apiKey, forHTTPHeaderField: "x-cg-demo-api-key")

        
       coinSubscription = URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global())
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                          throw URLError(.badServerResponse)
                      }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: [CoinModal].self, decoder: JSONDecoder())
            .sink (receiveCompletion:{ (compelition) in
                switch compelition {
                case .failure(let error):
                    print( error.localizedDescription)
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { [weak self] value in
                self?.allCoins = value
                self?.coinSubscription?.cancel()
            })
    }
}
        
        ///AutoCompleted Code
        //            .map(\.data)
        //            .decode(type: [CoinModal].self, decoder: JSONDecoder())
        //            .receive(on: DispatchQueue.main)
        //            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] value in
        //                self?.allCoins = value
        //            }
