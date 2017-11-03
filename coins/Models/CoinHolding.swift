//
//  CoinHolding.swift
//  coins
//
//  Created by Jeff on 10/30/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import Foundation

struct CoinHolding {
    private(set) public var coinName: String
    private(set) public var coinSymbol: String
    private(set) public var coinLogo: String
    private(set) public var quantity: Double
    private(set) public var price: Double
    
    init(coinName: String, coinSymbol: String, coinLogo: String, quantity: Double, price: Double) {
        self.coinName = coinName
        self.coinSymbol = coinSymbol
        self.coinLogo = coinLogo
        self.quantity = quantity
        self.price = price
    }
    
}
