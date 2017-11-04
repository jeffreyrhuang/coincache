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
    var coinHoldings: [CoinHolding] = []
//    private var coinHoldings = [
//        CoinHolding(coinName: "Bitcoin", coinSymbol: "BTC", coinLogo: "bitcoin.png", quantity: 10.5, price: 6000),
//        CoinHolding(coinName: "Monero", coinSymbol: "XMR", coinLogo: "monero.png", quantity: 3, price: 88),
//        CoinHolding(coinName: "Litecoin", coinSymbol: "LTC", coinLogo: "litecoin.png", quantity: 10, price: 55)
//    ]
    
    func getCoinHoldings() -> [CoinHolding] {
        return coinHoldings
    }
    
//    func getCoinDetail(forCoinSymbol symbol: String) -> CoinDetail {
//        return CoinDetail(marketCap: "100B", supply: "16M")
//    }
}
