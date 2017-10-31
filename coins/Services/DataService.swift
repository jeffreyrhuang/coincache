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
        CoinHolding(coinName: "Bitcoin", coinSymbol: "BTC", amount: 10.5),
        CoinHolding(coinName: "Monero", coinSymbol: "XMR", amount: 3)
    ]
    
    func getCoinHoldings() -> [CoinHolding] {
        return coinHoldings
    }
}
