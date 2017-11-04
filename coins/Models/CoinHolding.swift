//
//  CoinHolding.swift
//  coins
//
//  Created by Jeff on 10/30/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import Foundation

struct CoinHolding {
    private(set) public var name: String
    private(set) public var symbol: String
    private(set) public var logo: String
    private(set) public var quantity: Double
    private(set) public var price: Double
    private(set) public var price_btc: Double
    private(set) public var marketCap: String
    private(set) public var supply: String
    
    init(name: String,
         symbol: String,
         logo: String,
         quantity: Double,
         price: Double,
         price_btc: Double,
         marketCap: String,
         supply: String) {
        self.name = name
        self.symbol = symbol
        self.logo = logo
        self.quantity = quantity
        self.price = price
        self.price_btc = price_btc
        self.marketCap = marketCap
        self.supply = supply
    }
    
}
