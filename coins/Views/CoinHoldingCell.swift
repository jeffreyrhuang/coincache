//
//  CoinHoldingCell.swift
//  coins
//
//  Created by Jeff on 10/29/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

class CoinHoldingCell: UITableViewCell {
    
    // outlets for cell parts..

    @IBOutlet weak var coinLogo: UIImageView!
    @IBOutlet weak var coinSymbol: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var percent_change: UILabel!
    
    func updateViews(ownedCoin: Coin) {
        let logoImage = UIImage(named: ownedCoin.id)
        if logoImage != nil {
            coinLogo.image = logoImage
        } else {
            coinLogo.image = UIImage(named: "coinlogo")
        }
        coinSymbol.text = ownedCoin.symbol
        amount.text = "\(ownedCoin.amount)"
        value.text = "\(ownedCoin.amount * Double(ownedCoin.price_usd)!)"
        price.text = "\(ownedCoin.price_usd)"
        percent_change.text = "\(ownedCoin.percent_change_7d) %"
        if Double(ownedCoin.percent_change_7d)! > 0 {
            percent_change.textColor = UIColor(red: 0.0235, green: 0.7686, blue: 0, alpha: 1.0)
        } else if Double(ownedCoin.percent_change_7d)! < 0 {
            percent_change.textColor = UIColor.red
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
