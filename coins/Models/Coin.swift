//
//  Coin.swift
//  coins
//
//  Created by Jeff on 11/4/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import Foundation
import RealmSwift

class Coin: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var symbol: String = ""
    @objc dynamic var price: Double = 0
}
