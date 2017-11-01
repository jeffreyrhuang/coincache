//
//  CoinDetail.swift
//  coins
//
//  Created by Jeff on 11/1/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import Foundation

struct CoinDetail {
    private(set) public var marketCap: String
    private(set) public var supply: String
    
    init(marketCap: String, supply: String) {
        self.marketCap = marketCap
        self.supply = supply
    }
}
