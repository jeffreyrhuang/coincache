//
//  Coin.swift
//  coins
//
//  Created by Jeff on 11/4/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Coin:Object, Mappable {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var symbol = ""
    @objc dynamic var price_usd: Double = 0.0
    @objc dynamic var price_btc: Double = 0.0
    @objc dynamic var market_cap_usd = ""
    @objc dynamic var available_supply = ""
    @objc dynamic var percent_change_24h = ""
    @objc dynamic var percent_change_7d = ""
    
    // Optional
    @objc dynamic var logo = ""
    
    // Variables set by user
    @objc dynamic var isOwned: Bool = false
    @objc dynamic var amount: Double = 0.0
    
    // Computed value  // remove objc dynamic to make it read-only?
    @objc dynamic var value: Double {
        get {
            let x =  price_usd * amount
            return round(100 * x) / 100
        }
        set {
            self.value = price_usd * amount
        }
    }
    
    override static func ignoredProperties() -> [String] {
        return ["value"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id                  <- map["id"]
        name                <- map["name"]
        symbol              <- map["symbol"]
        price_usd           <- (map["price_usd"], TransformOf<Double, String>(fromJSON: {Double($0!)}, toJSON: {$0.map { String($0)}}))
        price_btc           <- (map["price_btc"], TransformOf<Double, String>(fromJSON: {Double($0!)}, toJSON: {$0.map { String($0)}}))
        market_cap_usd      <- map["market_cap_usd"]
        available_supply    <- map["available_supply"]
        percent_change_24h  <- map["percent_change_24h"]
        percent_change_7d   <- map["percent_change_7d"]
    }
}
