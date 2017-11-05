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
    @objc dynamic var price = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
        symbol  <- map["symbol"]
        price   <- map["price"]
    }
}
