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
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var percent_change: UILabel!
    
    func updateViews(ownedCoin: Coin) {
//        coinLogo.image = UIImage(named: ownedCoin.logo)
        coinSymbol.text = ownedCoin.symbol
        coinName.text = ownedCoin.name
        quantity.text = "\(ownedCoin.amount)"
        value.text = "\(ownedCoin.amount * Double(ownedCoin.price_usd)!)"
        price.text = "\(ownedCoin.price_usd)"
        percent_change.text = "\(ownedCoin.percent_change_7d) %"
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
