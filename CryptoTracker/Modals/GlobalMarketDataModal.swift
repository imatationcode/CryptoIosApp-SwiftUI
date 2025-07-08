//
//  GlobalMarketDataModal.swift
//  CryptoTracker
//
//  Created by Shivakumar Harijan on 05/07/25.
//

import Foundation
/*
 URL : https://api.coingecko.com/api/v3/global \
 JSONResponse :
 {
 "data": {
 "active_cryptocurrencies": 17582,
 "upcoming_icos": 0,
 "ongoing_icos": 49,
 "ended_icos": 3376,
 "markets": 1308,
 "total_market_cap": {
 "btc": 31519568.072063025,
 "eth": 1352875975.9411485,
 "ltc": 39337712089.38683,
 "bch": 7023555567.845605,
 "bnb": 5199128101.545617,
 "vef": 341217901885.23694,
 "vnd": 89179086022028460,
 "zar": 60027497670113.33,
 "xdr": 2570890998000.2993,
 "xag": 92267154038.70064,
 "xau": 1021268281.3940548,
 "bits": 31519568072063.023,
 "sats": 3151956807206302.5
 },
 "total_volume": {
 "btc": 744644.2744441914,
 "eth": 31961457.949374005,
 "ltc": 929346557.3552414,
 "bch": 165930269.97956997,
 "bnb": 122828490.67177726,
 "eos": 167729923833.14023,
 "xrp": 36122110014.25038,
 "xlm": 338441631280.31866,
 "link": 6105233994.60947,
 "dot": 23895947484.46631,
 },
 "market_cap_percentage": {
 "btc": 63.09649597523277,
 "eth": 8.921947645057939,
 "usdt": 4.652735215890321,
 "xrp": 3.8615154071806135,
 "bnb": 2.808341768755322,
 "sol": 2.31115272464372,
 "usdc": 1.8240318838737724,
 "trx": 0.7885867064361853,
 "doge": 0.7225729923793525,
 "steth": 0.6726389770876383
 },
 "market_cap_change_percentage_24h_usd": -4.238833131474086,
 "updated_at": 1751695939
 }
 }
 */

struct GlobalMarketDataModal: Codable {
    let data: MarketDataModal?
}

struct MarketDataModal: Codable {
//            let activeCryptocurrencies, upcomingIcos, ongoingIcos, endedIcos: Int?
//            let markets: Int?
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { (key, value) -> Bool in
            return key == "usd"
        }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume : String {
        if let item = totalVolume.first(where: { $0.key == "usd"
            
        }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        return (marketCapPercentage["btc"]?.formattedWithAbbreviations() ?? "0") + "%"
    }
}
