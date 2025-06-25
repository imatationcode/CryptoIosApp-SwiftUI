//
//  CoinModal.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 24/06/25.
//

    // Coin API DATA
    /*
     url :
     https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&symbols=btc&include_tokens=all&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=1h&locale=en&precision=full
     
     
     JSON DATA
     {
         "id": "bitcoin",
         "symbol": "btc",
         "name": "Bitcoin",
         "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
         "current_price": 105652.65330358183,
         "market_cap": 2102304762304,
         "market_cap_rank": 1,
         "fully_diluted_valuation": 2102304762304,
         "total_volume": 51108218366,
         "high_24h": 105927,
         "low_24h": 100177,
         "price_change_24h": 3687,
         "price_change_percentage_24h": 3.61593,
         "market_cap_change_24h": 75048602951,
         "market_cap_change_percentage_24h": 3.70198,
         "circulating_supply": 19882775,
         "total_supply": 19882775,
         "max_supply": 21000000,
         "ath": 111814,
         "ath_change_percentage": -5.42985,
         "ath_date": "2025-05-22T18:41:28.492Z",
         "atl": 67.81,
         "atl_change_percentage": 155842.17074,
         "atl_date": "2013-07-06T00:00:00.000Z",
         "roi": null,
         "last_updated": "2025-06-24T07:14:01.220Z",
         "sparkline_in_7d": {
           "price": [
             107133.14042003587,
             106850.03969811338,
             106772.70279319353,
             106574.44033966033,
             106168.65582350684,
           ]
         },
         "price_change_percentage_1h_in_currency": 0.1819011999423291
       },
     
     */


import Foundation

struct CoinModal: Identifiable, Codable {
    
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation, totalVolume: Double?
    let high24H, low24H, priceChange24H: Double?
    let priceChangePercentage24H: Double? 
    let marketCapChange24H: Int?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
//    let roi: NSNull?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage1HInCurrency: Double?
    let currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
//        case roi
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage1HInCurrency = "price_change_percentage_1h_in_currency"
        case currentHoldings
    }
    
    func upadateHoldings(amount: Double) -> CoinModal {
        return CoinModal(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: athDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage1HInCurrency: priceChangePercentage1HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingValue: Double {
        return currentPrice * (currentHoldings ?? 0)
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable {
    let price: [Double]?
}
