//
//  DataService.swift
//  coins
//
//  Created by Jeff on 10/30/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import Foundation

class DataService {
    static let instance = DataService()
    
    private let coinHoldings = [
        CoinHolding(coinName: "Bitcoin", coinSymbol: "BTC", coinLogo: "bitcoin.png", amount: 10.5),
        CoinHolding(coinName: "Monero", coinSymbol: "XMR", coinLogo: "monero.png", amount: 3),
        CoinHolding(coinName: "Litecoin", coinSymbol: "LTC", coinLogo: "litecoin.png", amount: 10)
    ]
    
    func getCoinHoldings() -> [CoinHolding] {
        return coinHoldings
    }
    
    func getCoinDetail(forCoinSymbol symbol: String) -> CoinDetail {
        return CoinDetail(marketCap: "100B", supply: "16M")
    }
}
